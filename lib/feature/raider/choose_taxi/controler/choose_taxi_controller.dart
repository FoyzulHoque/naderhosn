/*
import 'dart:convert'; // For jsonDecode
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart'; // Import package
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http; // Import http package
import '../../../../core/const/app_colors.dart';
import '../../../../core/network_caller/endpoints.dart';
import '../model/choose_taxi_model.dart';
import 'choose_taxi_api_controller.dart';

// IMPORTANT: Replace with your actual Google Directions API Key
const String GOOGLE_DIRECTIONS_API_KEY = "${Urls.googleApiKey}";

class ChooseTaxiController extends GetxController {
  final ChooseTaxiApiController apiController = Get.put(ChooseTaxiApiController());

  var isBottomSheetOpen = false.obs;
  var isLoadingMap = true.obs;
  var isLoadingDirections = false.obs; // For directions loading

  var pickupPosition = Rxn<LatLng>();
  var dropOffPosition = Rxn<LatLng>();

  var customMarkerIconPickup = BitmapDescriptor.defaultMarker.obs;
  var customMarkerIconDropOff = BitmapDescriptor.defaultMarker.obs;
  var customMarkerIconCar = BitmapDescriptor.defaultMarker.obs;

  var markers = <Marker>{}.obs;
  // Initialize polyline with an empty list of points
  var polyline = Polyline(
    polylineId: const PolylineId("route_polyline"), // Changed ID for clarity
    points: <LatLng>[],
    color: AppColors.polylineColors.isNotEmpty
        ? AppColors.polylineColors[0]
        : Colors.blue, // Default color
    width: 5,
  ).obs;

  var currentRidePlan = Rxn<RidePlan2>();

  @override
  void onInit() {
    super.onInit();
    // loadAndDisplayRideData might be called with specific coords from the screen
    // or without if it's an initial load without args.
    // If called from screen with args, it will override.
    // Otherwise, this initial call will attempt to load based on defaults or no specific route.
    loadAndDisplayRideData();
  }

  Future<void> loadAndDisplayRideData({
    double? initialPickupLat,
    double? initialPickupLng,
    double? initialDropOffLat,
    double? initialDropOffLng,
  }) async {
    isLoadingMap.value = true;
    isLoadingDirections.value = true; // Start loading directions too
    markers.clear();
    polyline.value = polyline.value.copyWith(pointsParam: []); // Clear previous polyline points


    await Future.wait([
      _loadCustomMarker("Pickup", MarkerType.pickup),
      _loadCustomMarker("Drop-off", MarkerType.dropOff),
      _loadCustomMarker("Car", MarkerType.car),
    ]);

    await apiController.chooseTaxiApiMethod();

    if (apiController.errorMessage.value.isNotEmpty) {
      Get.snackbar("Error",
          "Failed to load ride data: ${apiController.errorMessage.value}");
      _resetMapStateToError();
      return;
    }

    if (apiController.rideDataList.isNotEmpty) {
      currentRidePlan.value = apiController.rideDataList.first;
      final ridePlanData = currentRidePlan.value!;

      // Use initial arguments if provided, otherwise use data from API
      double pLat = initialPickupLat ?? ridePlanData.pickupLat ?? 0.0;
      double pLng = initialPickupLng ?? ridePlanData.pickupLng ?? 0.0;
      double dLat = initialDropOffLat ?? ridePlanData.dropOffLat ?? 0.0;
      double dLng = initialDropOffLng ?? ridePlanData.dropOffLng ?? 0.0;


      if (pLat != 0.0 && pLng != 0.0) {
        pickupPosition.value = LatLng(pLat, pLng);
        addMapMarker(
            pickupPosition.value!,
            ridePlanData.pickup ?? (initialPickupLat != null ? "Pickup" : "Unknown Pickup"),
            MarkerType.pickup);
      } else {
        pickupPosition.value = null;
        print("Warning: Pickup coordinates are missing or invalid.");
      }

      if (dLat != 0.0 && dLng != 0.0) {
        dropOffPosition.value = LatLng(dLat, dLng);
        addMapMarker(
            dropOffPosition.value!,
            ridePlanData.dropOff ?? (initialDropOffLat != null ? "Drop-off" : "Unknown Drop-off"),
            MarkerType.dropOff);
      } else {
        dropOffPosition.value = null;
        print("Warning: Drop-off coordinates are missing or invalid.");
      }

      // Fetch and draw route polyline if both pickup and dropOff are set
      if (pickupPosition.value != null && dropOffPosition.value != null) {
        await _getRoutePolyline(
            pickupPosition.value!, dropOffPosition.value!);
      } else {
        updatePolyline([]); // Pass empty list to clear visual polyline
        isLoadingDirections.value = false;
      }


      if (ridePlanData.carTransport != null) {
        for (final car in ridePlanData.carTransport!) {
          if (car.driverLat != null && car.driverLng != null) {
            final LatLng driverPos = LatLng(car.driverLat!, car.driverLng!);
            addMapMarker(
              driverPos,
              car.serviceType ?? 'Car ID: ${car.id ?? "N/A"}',
              MarkerType.car,
              idSuffix: car.id ?? 'car_${DateTime.now().millisecondsSinceEpoch}',
            );
          } else {
            print("Warning: Driver coordinates missing for car transport ${car.id}");
          }
        }
      }
    } else {
      Get.snackbar("Info", "No ride plans found.");
      _resetMapStateToError(); // Also clears map for no data case
    }
    isLoadingMap.value = false;
    // isLoadingDirections is set within _getRoutePolyline or if positions are null
  }

  void _resetMapStateToError() {
    isLoadingMap.value = false;
    isLoadingDirections.value = false;
    pickupPosition.value = null;
    dropOffPosition.value = null;
    currentRidePlan.value = null;
    updatePolyline([]); // Clear polyline
    markers.clear(); // Clear markers
  }


  // Method to fetch and draw polyline snapped to roads
  Future<void> _getRoutePolyline(LatLng origin, LatLng destination) async {
    isLoadingDirections.value = true;
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    try {
      // Construct the Google Directions API URL
      String url =
          "https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$GOOGLE_DIRECTIONS_API_KEY";

      print("Directions API URL: $url"); // For debugging

      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'OK' && (data['routes'] as List).isNotEmpty) {
          // Get the encoded polyline string
          String encodedPolyline = data['routes'][0]['overview_polyline']['points'];
          // Decode the polyline
          List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);
          if (result.isNotEmpty) {
            for (var point in result) {
              polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            }
          }
        } else {
          print("Directions API Error: ${data['status']} - ${data['error_message'] ?? 'No routes found'}");
          Get.snackbar("Directions Error", data['error_message'] ?? "Could not fetch route details.");
        }
      } else {
        print("Directions API HTTP Error: ${response.statusCode}");
        Get.snackbar("Directions Error", "Failed to connect to directions service.");
      }
    } catch (e) {
      print("Error fetching directions: $e");
      Get.snackbar("Directions Error", "An error occurred while fetching route: $e");
    }

    updatePolyline(polylineCoordinates); // Update map polyline
    isLoadingDirections.value = false;
  }

  // Update the polyline on the map
  void updatePolyline(List<LatLng> points) {
    print("Updating polyline with ${points.length} points.");
    polyline.value = Polyline(
        polylineId: const PolylineId("route_polyline"), // Use the same ID
        points: points, // These points will form the route along roads
        color: AppColors.polylineColors.isNotEmpty
            ? AppColors.polylineColors[0]
            : Colors.deepPurple, // Use your desired color
        width: 5, // Adjust width as needed
        consumeTapEvents: true,
        onTap: () {
          print("Polyline tapped!");
        }
    );
  }


  void toggleBottomSheet() {
    isBottomSheetOpen.value = !isBottomSheetOpen.value;
  }

  void addMapMarker(LatLng position, String label, MarkerType type,
      {String? idSuffix}) {
    BitmapDescriptor icon;
    String markerIdBase;

    switch (type) {
      case MarkerType.pickup:
        icon = customMarkerIconPickup.value;
        markerIdBase = "pickup";
        break;
      case MarkerType.dropOff:
        icon = customMarkerIconDropOff.value;
        markerIdBase = "dropOff";
        break;
      case MarkerType.car:
        icon = customMarkerIconCar.value;
        markerIdBase = "car";
        break;
    }

    final String markerId =
    idSuffix != null ? "${markerIdBase}_$idSuffix" : markerIdBase;

    // Avoid adding duplicate markers if they already exist (e.g., on hot reload)
    if (!markers.any((m) => m.markerId == MarkerId(markerId))) {
      final marker = Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: InfoWindow(title: label),
        icon: icon,
      );
      markers.add(marker);
    }
  }

  Future<void> _loadCustomMarker(String label, MarkerType type) async {
    String imagePath;
    int targetSize;

    switch (type) {
      case MarkerType.pickup:
        imagePath = 'assets/images/my_location.png';
        targetSize = 100;
        break;
      case MarkerType.dropOff:
        imagePath = 'assets/images/driver_location.png';
        targetSize = 100;
        break;
      case MarkerType.car:
        imagePath = 'assets/images/car.png';
        targetSize = 80;
        break;
    }

    final BitmapDescriptor loadedIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(targetSize.toDouble(), targetSize.toDouble())),
      imagePath,
    );

    switch (type) {
      case MarkerType.pickup:
        customMarkerIconPickup.value = loadedIcon;
        break;
      case MarkerType.dropOff:
        customMarkerIconDropOff.value = loadedIcon;
        break;
      case MarkerType.car:
        customMarkerIconCar.value = loadedIcon;
        break;
    }
  }
}

enum MarkerType {
  pickup,
  dropOff,
  car,
}
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/Get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../../core/const/app_colors.dart';
import '../../../../core/network_caller/endpoints.dart';
import '../model/choose_taxi_model.dart';
import 'choose_taxi_api_controller.dart';
import 'dart:math' show min, max;

const String GOOGLE_DIRECTIONS_API_KEY = "${Urls.googleApiKey}";

class ChooseTaxiController extends GetxController {
  final ChooseTaxiApiController apiController = Get.put(ChooseTaxiApiController());

  var isBottomSheetOpen = false.obs;
  var isLoadingMap = true.obs;
  var isLoadingDirections = false.obs;

  var pickupPosition = Rxn<LatLng>();
  var dropOffPosition = Rxn<LatLng>();

  var customMarkerIconPickup = BitmapDescriptor.defaultMarker.obs;
  var customMarkerIconDropOff = BitmapDescriptor.defaultMarker.obs;
  var customMarkerIconCar = BitmapDescriptor.defaultMarker.obs;

  var markers = <Marker>{}.obs;
  var polyline = Polyline(
    polylineId: const PolylineId("route_polyline"),
    points: <LatLng>[],
    color: AppColors.polylineColors.isNotEmpty ? AppColors.polylineColors[0] : Colors.blue,
    width: 5,
  ).obs;

  var currentRidePlan = Rxn<RidePlan2>();
  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    // Only load data when triggered by screen arguments
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> loadAndDisplayRideData({
    String? initialPickup,
    String? initialDropOff,
    double? initialPickupLat,
    double? initialPickupLng,
    double? initialDropOffLat,
    double? initialDropOffLng,
  }) async {
    // Validate all required parameters
    if (initialPickup == null || initialDropOff == null ||
        initialPickupLat == null || initialPickupLng == null ||
        initialDropOffLat == null || initialDropOffLng == null ||
        [initialPickupLat, initialPickupLng, initialDropOffLat, initialDropOffLng].any((v) => v == 0.0)) {
      Get.snackbar("Error", "Please provide valid pickup and drop-off locations.");
      _resetMapStateToError();
      isLoadingMap.value = false;
      isLoadingDirections.value = false;
      return;
    }

    isLoadingMap.value = true;
    isLoadingDirections.value = true;
    markers.clear();
    polyline.value = polyline.value.copyWith(pointsParam: []);

    try {
      await Future.wait([
        _loadCustomMarker("Pickup", MarkerType.pickup),
        _loadCustomMarker("Drop-off", MarkerType.dropOff),
        _loadCustomMarker("Car", MarkerType.car),
      ]);

      await apiController.chooseTaxiApiMethod();

      if (apiController.errorMessage.value.isNotEmpty) {
        Get.snackbar("Error", "Failed to load ride data: ${apiController.errorMessage.value}");
        _resetMapStateToError();
        return;
      }

      if (apiController.rideDataList.isEmpty) {
        Get.snackbar("Info", "No ride plans found for the given locations.");
        _resetMapStateToError();
        return;
      }

      currentRidePlan.value = apiController.rideDataList.first;
      final ridePlanData = currentRidePlan.value!;

      pickupPosition.value = LatLng(initialPickupLat, initialPickupLng);
      addMapMarker(
        pickupPosition.value!,
        ridePlanData.pickup ?? initialPickup,
        MarkerType.pickup,
      );

      dropOffPosition.value = LatLng(initialDropOffLat, initialDropOffLng);
      addMapMarker(
        dropOffPosition.value!,
        ridePlanData.dropOff ?? initialDropOff,
        MarkerType.dropOff,
      );

      if (pickupPosition.value != null && dropOffPosition.value != null) {
        await _getRoutePolyline(pickupPosition.value!, dropOffPosition.value!);
        final List<LatLng> allPositions = [
          pickupPosition.value!,
          dropOffPosition.value!,
          ...markers.where((m) => m.markerId.value.startsWith('car_')).map((m) => m.position),
        ];
        if (allPositions.isNotEmpty) {
          final bounds = LatLngBounds(
            southwest: LatLng(
              allPositions.map((p) => p.latitude).reduce(min),
              allPositions.map((p) => p.longitude).reduce(min),
            ),
            northeast: LatLng(
              allPositions.map((p) => p.latitude).reduce(max),
              allPositions.map((p) => p.longitude).reduce(max),
            ),
          );
          mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
        }
      } else {
        updatePolyline([]);
        isLoadingDirections.value = false;
      }

      if (ridePlanData.carTransport != null && ridePlanData.carTransport!.isNotEmpty) {
        for (final car in ridePlanData.carTransport!) {
          if (car.driverLat != null && car.driverLng != null) {
            final LatLng driverPos = LatLng(car.driverLat!, car.driverLng!);
            addMapMarker(
              driverPos,
              car.serviceType ?? 'Car ID: ${car.id ?? "Unknown"}',
              MarkerType.car,
              idSuffix: car.id ?? 'car_${DateTime.now().millisecondsSinceEpoch}',
            );
          }
        }
      }
    } catch (e) {
      print("Error in loadAndDisplayRideData: $e");
      Get.snackbar("Error", "An unexpected error occurred: $e");
      _resetMapStateToError();
    } finally {
      isLoadingMap.value = false;
      isLoadingDirections.value = false;
    }
  }

  void _resetMapStateToError() {
    isLoadingMap.value = false;
    isLoadingDirections.value = false;
    pickupPosition.value = null;
    dropOffPosition.value = null;
    currentRidePlan.value = null;
    updatePolyline([]);
    markers.clear();
  }

  Future<void> _getRoutePolyline(LatLng origin, LatLng destination) async {
    isLoadingDirections.value = true;
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    try {
      String url =
          "https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$GOOGLE_DIRECTIONS_API_KEY";

      print("Directions API URL: $url");
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'OK' && (data['routes'] as List).isNotEmpty) {
          String encodedPolyline = data['routes'][0]['overview_polyline']['points'];
          List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);
          if (result.isNotEmpty) {
            for (var point in result) {
              polylineCoordinates.add(LatLng(point.latitude, point.longitude));
            }
          }
        } else {
          print("Directions API Error: ${data['status']} - ${data['error_message'] ?? 'No routes found'}");
          Get.snackbar("Directions Error", data['error_message'] ?? "Could not fetch route details.");
        }
      } else {
        print("Directions API HTTP Error: ${response.statusCode}");
        Get.snackbar("Directions Error", "Failed to connect to directions service.");
      }
    } catch (e) {
      print("Error fetching directions: $e");
      Get.snackbar("Directions Error", "An error occurred while fetching route: $e");
    }

    updatePolyline(polylineCoordinates);
    isLoadingDirections.value = false;
  }

  void updatePolyline(List<LatLng> points) {
    print("Updating polyline with ${points.length} points.");
    polyline.value = Polyline(
      polylineId: const PolylineId("route_polyline"),
      points: points,
      color: AppColors.polylineColors.isNotEmpty ? AppColors.polylineColors[0] : Colors.deepPurple,
      width: 5,
      consumeTapEvents: true,
      onTap: () {
        print("Polyline tapped!");
      },
    );
  }

  void toggleBottomSheet() {
    isBottomSheetOpen.value = !isBottomSheetOpen.value;
  }

  void addMapMarker(LatLng position, String label, MarkerType type, {String? idSuffix}) {
    BitmapDescriptor icon;
    String markerIdBase;

    switch (type) {
      case MarkerType.pickup:
        icon = customMarkerIconPickup.value;
        markerIdBase = "pickup";
        break;
      case MarkerType.dropOff:
        icon = customMarkerIconDropOff.value;
        markerIdBase = "dropOff";
        break;
      case MarkerType.car:
        icon = customMarkerIconCar.value;
        markerIdBase = "car";
        break;
    }

    final String markerId = idSuffix != null && idSuffix.isNotEmpty
        ? "${markerIdBase}_$idSuffix"
        : "${markerIdBase}_${DateTime.now().millisecondsSinceEpoch}_${markers.length}";

    if (!markers.any((m) => m.markerId == MarkerId(markerId))) {
      final marker = Marker(
        markerId: MarkerId(markerId),
        position: position,
        infoWindow: InfoWindow(title: label),
        icon: icon,
      );
      markers.add(marker);
      print("Added marker: $markerId at position $position");
    } else {
      print("Marker $markerId already exists, skipping.");
    }
  }

  Future<void> _loadCustomMarker(String label, MarkerType type) async {
    String imagePath;
    int targetSize;

    switch (type) {
      case MarkerType.pickup:
        imagePath = 'assets/images/my_location.png';
        targetSize = 100;
        break;
      case MarkerType.dropOff:
        imagePath = 'assets/images/driver_location.png';
        targetSize = 100;
        break;
      case MarkerType.car:
        imagePath = 'assets/images/car.png';
        targetSize = 80;
        break;
    }

    try {
      final BitmapDescriptor loadedIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(targetSize.toDouble(), targetSize.toDouble())),
        imagePath,
      );
      switch (type) {
        case MarkerType.pickup:
          customMarkerIconPickup.value = loadedIcon;
          break;
        case MarkerType.dropOff:
          customMarkerIconDropOff.value = loadedIcon;
          break;
        case MarkerType.car:
          customMarkerIconCar.value = loadedIcon;
          break;
      }
      print("Loaded custom marker for $type from $imagePath");
    } catch (e) {
      print("Error loading custom marker for $type from $imagePath: $e");
      switch (type) {
        case MarkerType.pickup:
          customMarkerIconPickup.value = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
          break;
        case MarkerType.dropOff:
          customMarkerIconDropOff.value = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
          break;
        case MarkerType.car:
          customMarkerIconCar.value = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
          break;
      }
    }
  }
}

enum MarkerType {
  pickup,
  dropOff,
  car,
}