import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  var isBottomSheetOpen = false.obs;
  var markerPosition = const LatLng(23.8103, 90.4125).obs; // fallback Dhaka
  var customMarkerIcon = BitmapDescriptor.defaultMarker.obs;

  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    _loadCustomMarkerWithLabel("You");
    _trackCurrentLocation(); // ✅ realtime tracking
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  // Update marker position manually
  void updateMarkerPosition(LatLng position) {
    markerPosition.value = position;
  }

  // ✅ Track user current location
  void _trackCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check service
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    // Listen to location changes
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1, // প্রতি 10 মিটার পর আপডেট হবে
      ),
    ).listen((Position position) {
      final currentLatLng = LatLng(position.latitude, position.longitude);
      markerPosition.value = currentLatLng;

      // Camera move করাও
      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLng(currentLatLng),
        );
      }
    });
  }

  // ✅ Custom Marker with Label
  Future<void> _loadCustomMarkerWithLabel(String label) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final ByteData data = await rootBundle.load(
      'assets/images/my_location.png',
    );
    final Uint8List bytes = data.buffer.asUint8List();

    final ui.Codec codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: 120,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ui.Image image = fi.image;

    Paint paint = Paint();
    canvas.drawImage(image, Offset(0, 0), paint);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: label,
      style: const TextStyle(
        fontSize: 18,
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
}
