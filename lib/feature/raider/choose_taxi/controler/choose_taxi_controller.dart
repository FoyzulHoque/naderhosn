import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'choose_taxi_api_controller.dart';
// Assuming the required models (RideDataModel, RidePlan, NearbyDriver) are accessible

/*
class ChooseTaxiController extends GetxController {
  final ChooseTaxiApiController apiController = Get.put(ChooseTaxiApiController());

  var rideData = Rxn<dynamic>(); // Stores the full RideDataModel
  var isLoading = false.obs;
  var isBottomSheetOpen = false.obs;

  // Expose RidePlan and NearbyDrivers for UI access
  var ridePlan = Rxn<dynamic>();
  var nearbyDrivers = RxList<dynamic>();

  // Initialized as reactive nullable variables (Rxn<LatLng>)
  var markerPosition = Rxn<LatLng>();
  var destinationPosition = Rxn<LatLng>();

  // Marker icons
  var customMarkerIcon = BitmapDescriptor.defaultMarker.obs;
  var customMarkerIconDriver = BitmapDescriptor.defaultMarker.obs;
  var customMarkerCar = BitmapDescriptor.defaultMarker.obs;

  // Map markers & polyline
  var markers = <Marker>{}.obs;
  var polyline = Polyline(
    polylineId: const PolylineId("line_1"),
    points: <LatLng>[],
    color: Colors.blue,
    width: 5,
  ).obs;

  // Properties to hold location data passed from the screen
  double? initialPickupLat;
  double? initialPickupLng;
  double? initialDropOffLat;
  double? initialDropOffLng;


  @override
  void onInit() {
    super.onInit();
    // loadRideData will be called from the screen once arguments are available.
  }

  // Accepts location data and triggers the map setup
  Future<void> loadRideData({
    required double pLat,
    required double pLng,
    required double dLat,
    required double dLng,
  }) async {
    isLoading.value = true;

    // Store the coordinates for potential future use
    initialPickupLat = pLat;
    initialPickupLng = pLng;
    initialDropOffLat = dLat;
    initialDropOffLng = dLng;

    // 1. Load marker icons first
    await Future.wait([
      _loadCustomMarker("You"),
      _loadCustomMarker2("Driver"),
      _loadCustomMarker3("Car"),
    ]);

    await apiController.chooseTaxiApiMethod();

    if (apiController.rideDataList.isNotEmpty) {
      rideData.value = apiController.rideDataList.first;
      final data = rideData.value;

      // Set observable data for UI
      ridePlan.value = data.ridePlan;
      nearbyDrivers.value = data.nearbyDrivers;

      // 2. Set Pickup Position
      markerPosition.value = LatLng(data.ridePlan.pickupLat, data.ridePlan.pickupLng);

      // 3. Set DropOff Position
      destinationPosition.value = LatLng(data.ridePlan.dropOffLat, data.ridePlan.dropOffLng);

      // 4. Add Pickup and Destination markers
      addMarker(markerPosition.value!, data.ridePlan.pickup);
      addMarkerDriver(destinationPosition.value!, data.ridePlan.dropOff);

      // 5. Add Polyline
      updatePolyline();

      // 6. Add all cars via loop
      for (final driver in data.nearbyDrivers) {
        final LatLng pos = LatLng(driver.lat, driver.lng);
        addMarkerCarAvailable(pos, driver.vehicleName ?? 'Available Car');
      }
    } else {
      // If data loading fails, ensure markerPosition is null so the UI can show the error text
      markerPosition.value = null;
    }

    isLoading.value = false;
  }

  void updatePolyline() {
    // Safely retrieve non-null values for LatLng list
    List<LatLng> points = [];
    if (markerPosition.value != null && destinationPosition.value != null) {
      points = [markerPosition.value!, destinationPosition.value!];
    }

    polyline.value = Polyline(
      polylineId: const PolylineId("line_1"),
      points: points,
      color: Colors.blue,
      width: 5,
    );
  }

  // MARKER HELPERS (Kept as is)
  void addMarker(LatLng position, String id) {
    final marker = Marker(
      markerId: MarkerId(id),
      position: position,
      icon: customMarkerIcon.value,
      infoWindow: InfoWindow(title: id),
    );
    markers.add(marker);
  }

  void addMarkerDriver(LatLng position, String id) {
    final marker = Marker(
      markerId: MarkerId(id),
      position: position,
      icon: customMarkerIconDriver.value,
      infoWindow: InfoWindow(title: id),
    );
    markers.add(marker);
  }

  void addMarkerCarAvailable(LatLng position, String id) {
    final marker = Marker(
      markerId: MarkerId(id),
      position: position,
      icon: customMarkerCar.value,
      infoWindow: InfoWindow(title: id),
    );
    markers.add(marker);
  }

  // LOAD CUSTOM MARKERS (Using simplified BitmapDescriptor.fromAssetImage)
  Future<void> _loadCustomMarker(String name) async {
    final icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      "assets/images/my_location.png",
    );
    customMarkerIcon.value = icon;
  }

  Future<void> _loadCustomMarker2(String name) async {
    final icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      "assets/images/driver_location.png",
    );
    customMarkerIconDriver.value = icon;
  }

  Future<void> _loadCustomMarker3(String name) async {
    final icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      "assets/images/car.png",
    );
    customMarkerCar.value = icon;
  }
}*/



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle, ByteData; // Required for _bitmapFromAsset
import 'dart:ui' as ui; // Required for instantiateImageCodec, ImageByteFormat
import '../controler/choose_taxi_api_controller.dart'; // Ensure this path is correct

class DeliveryMapController extends GetxController {
  // Ensure ChooseTaxiApiController is correctly put/found (it's needed by ExpandedBottomSheet)
  final ChooseTaxiApiController apiController = Get.put(ChooseTaxiApiController());

  final LatLng pickupLocation = LatLng(40.650002, -73.949997);
  final LatLng deliveryLocation = LatLng(40.712776, -74.005974);

  final markers = <Marker>{}.obs;
  final polylines = <Polyline>{}.obs;

  late BitmapDescriptor pickupIcon;
  late BitmapDescriptor deliveryIcon;

  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    _loadCustomIcons();
  }

  Future<void> _loadCustomIcons() async {
    // Note: The original code had a missing import for ui.instantiateImageCodec
    pickupIcon = await _bitmapFromAsset('assets/images/location1.png');
    deliveryIcon = await _bitmapFromAsset2('assets/images/location2.png');
    _setupMapData();
  }

  Future<BitmapDescriptor> _bitmapFromAsset(
      String path, {
        int width = 100,
      }) async {
    final ByteData byteData = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec( // Use ui.instantiateImageCodec
      byteData.buffer.asUint8List(),
      targetWidth: width,
    );
    final frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png); // Use ui.ImageByteFormat
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  Future<BitmapDescriptor> _bitmapFromAsset2(
      String path, {
        int width = 150,
      }) async {
    final ByteData byteData = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec( // Use ui.instantiateImageCodec
      byteData.buffer.asUint8List(),
      targetWidth: width,
    );
    final frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png); // Use ui.ImageByteFormat
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  void _setupMapData() {
    final pickupMarker = Marker(
      markerId: MarkerId('pickup'),
      position: pickupLocation,
      icon: pickupIcon,
      infoWindow: InfoWindow(title: 'Pickup'),
    );

    final deliveryMarker = Marker(
      markerId: MarkerId('delivery'),
      position: deliveryLocation,
      icon: deliveryIcon,
      infoWindow: InfoWindow(title: 'Delivery'),
    );

    final polyline = Polyline(
      polylineId: PolylineId('route'),
      points: [pickupLocation, deliveryLocation],
      color: const Color(0xFFFFDC72),
      width: 8,
      patterns: [PatternItem.dot, PatternItem.gap(10)], // DOTTED LINE
    );

    markers.value = {pickupMarker, deliveryMarker};
    polylines.value = {polyline};
  }
}