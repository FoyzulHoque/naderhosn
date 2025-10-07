import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../confirm_pickup/controler/driver_infor_api_controller.dart';

class PickupAcceptController extends GetxController {
  var isBottomSheetOpen = false.obs;
  var isLoading = false.obs;
  var markerPosition = LatLng(23.749341, 90.437213).obs; // Initial fallback (Pickup)
  var destinationPosition = LatLng(23.749704, 90.430164).obs; // Initial fallback (Dropoff)
  var customMarkerIcon = BitmapDescriptor.defaultMarker.obs;
  var customMarkerIconDriver = BitmapDescriptor.defaultMarker.obs;
  var customMarkerCar = BitmapDescriptor.defaultMarker.obs;
  var markers = <Marker>{}.obs;
  var polyline = Polyline(
    polylineId: PolylineId("line_1"),
    points: <LatLng>[],
    color: Colors.blue,
    width: 5,
  ).obs;

  // Time-related variables from API
  var pickupDate = ''.obs;
  var pickupTime = ''.obs;
  var rideTime = 0.obs;
  var waitingTime = 0.obs;

  final DriverInfoApiController apiController = Get.put(DriverInfoApiController());

  @override
  void onInit() async {
    super.onInit();

    // Assume id is passed via Get.arguments when navigating to this screen
    final String? id = Get.arguments as String?;

    if (id != null) {
      await apiController.driverInfoApiMethod(id);
    }

    final ride = apiController.rideData.value;
    if (ride != null) {
      // Set dynamic positions from API, fallback to static if null
      markerPosition.value = LatLng(
        ride.pickupLat ?? 23.749341,
        ride.pickupLng ?? 90.437213,
      );
      destinationPosition.value = LatLng(
        ride.dropOffLat ?? 23.749704,
        ride.dropOffLng ?? 90.430164,
      );

      // Add driver marker if available
      if (ride.driverLat != null && ride.driverLng != null) {
        addMarkerCarAvailable(
          LatLng(ride.driverLat!, ride.driverLng!),
          'Driver',
        );
      }

      // Set time-related data from API
      pickupDate.value = ride.pickupDate ?? '';
      pickupTime.value = ride.pickupTime ?? '';
      rideTime.value = ride.rideTime ?? 0;
      waitingTime.value = ride.waitingTime ?? 0;
    }

    // Load custom markers with appropriate labels
    await _loadCustomMarker("Pickup");
    await _loadCustomMarker2("Driver");
    await _loadCustomMarkerCar("Dropoff");

    addMarker(markerPosition.value, 'Pickup');
    addMarkerDriver(destinationPosition.value, 'Dropoff');
  }

  // Toggle bottom sheet visibility
  void toggleBottomSheet() {
    isBottomSheetOpen.value = !isBottomSheetOpen.value;
  }

  void addMarkerCarAvailable(LatLng position, String label) {
    final marker = Marker(
      markerId: MarkerId(label),
      position: position,
      infoWindow: InfoWindow(title: label),
      icon: customMarkerCar.value,
    );
    markers.add(marker);
  }

  void addMarker(LatLng position, String label) {
    final marker = Marker(
      markerId: MarkerId(label),
      position: position,
      infoWindow: InfoWindow(title: label),
      icon: customMarkerIcon.value,
    );
    markers.add(marker);
  }

  void addMarkerDriver(LatLng position, String label) {
    final marker = Marker(
      markerId: MarkerId(label),
      position: position,
      infoWindow: InfoWindow(title: label),
      icon: customMarkerCar.value,
    );
    markers.add(marker);
    updatePolyline();
  }

  void updatePolyline() {
    List<LatLng> points = [markerPosition.value, destinationPosition.value];

    polyline.value = Polyline(
      polylineId: PolylineId("line_1"),
      points: points,
      color: Colors.blue,
      width: 5,
    );
  }

  // Load custom marker with label
  Future<void> _loadCustomMarker(String label) async {
    isLoading.value = true;
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final ByteData data = await rootBundle.load(
      'assets/images/my_location.png',
    );
    final Uint8List bytes = data.buffer.asUint8List();

    final ui.Codec codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: 200,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ui.Image image = fi.image;

    Paint paint = Paint();
    canvas.drawImage(image, Offset(0, 0), paint);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: label,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.yellow,
      ),
    );

    textPainter.layout();

    final double textX = (image.width - textPainter.width) / 2;
    final double textY = image.height.toDouble() + 4;

    textPainter.paint(canvas, Offset(textX, textY));

    final ui.Image finalImage = await pictureRecorder.endRecording().toImage(
      image.width,
      image.height + textPainter.height.toInt() + 8,
    );

    final ByteData? finalByteData = await finalImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List finalBytes = finalByteData!.buffer.asUint8List();

    customMarkerIcon.value = BitmapDescriptor.fromBytes(finalBytes);
  }

  Future<void> _loadCustomMarker2(String label) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final ByteData data = await rootBundle.load(
      'assets/images/driver_location.png',
    );
    final Uint8List bytes = data.buffer.asUint8List();

    final ui.Codec codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: 100,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ui.Image image = fi.image;

    Paint paint = Paint();
    canvas.drawImage(image, Offset(0, 0), paint);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: label,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.yellow,
      ),
    );

    textPainter.layout();

    final double textX = (image.width - textPainter.width) / 2;
    final double textY = image.height.toDouble() + 4;

    textPainter.paint(canvas, Offset(textX, textY));

    final ui.Image finalImage = await pictureRecorder.endRecording().toImage(
      image.width,
      image.height + textPainter.height.toInt() + 8,
    );

    final ByteData? finalByteData = await finalImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List finalBytes = finalByteData!.buffer.asUint8List();

    customMarkerIconDriver.value = BitmapDescriptor.fromBytes(finalBytes);
  }

  Future<void> _loadCustomMarkerCar(String label) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final ByteData data = await rootBundle.load('assets/images/car.png');
    final Uint8List bytes = data.buffer.asUint8List();

    final ui.Codec codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: 70,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ui.Image image = fi.image;

    Paint paint = Paint();
    canvas.drawImage(image, Offset(0, 0), paint);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: label,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.yellow,
      ),
    );

    textPainter.layout();

    final double textX = (image.width - textPainter.width) / 2;
    final double textY = image.height.toDouble() + 4;

    textPainter.paint(canvas, Offset(textX, textY));

    final ui.Image finalImage = await pictureRecorder.endRecording().toImage(
      image.width,
      image.height + textPainter.height.toInt() + 8,
    );

    final ByteData? finalByteData = await finalImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List finalBytes = finalByteData!.buffer.asUint8List();

    customMarkerCar.value = BitmapDescriptor.fromBytes(finalBytes);
    isLoading.value = false;
  }
}