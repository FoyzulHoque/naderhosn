import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/bottom_nav_user/screen/bottom_nav_user.dart';
import '../widget/background_image_for_location.dart';

class AddLocationScreen extends StatelessWidget {
  const AddLocationScreen({super.key});

  // Remove the duplicate function from here and use the one below

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundImageForLocation(
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      Get.offAll(() => BottomNavbarUser());
                    },
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFF9F8FA)),
                      ),
                      child: const Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 80,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 290),
                        Expanded(
                          child: Text(
                            "We need to know your location in order to suggest nearby stations",
                            style: globalTextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 166,
                          width: 327,
                          child: Column(
                            children: [
                              CustomButton(
                                title: "Use Current Location",
                                onPress: () async {
                                  // Show loading indicator
                                  Get.dialog(
                                    Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.amber,
                                      ),
                                    ),
                                    barrierDismissible: false,
                                  );

                                  Position? position = await getCurrentLocation();

                                  // Close loading dialog
                                  Get.back();

                                  if (position != null) {
                                    Get.offAll(() => BottomNavbarUser(),
                                        arguments: {
                                          "lat": position.latitude,
                                          "lng": position.longitude,
                                          "index": 0, // Home tab open হবে
                                        });
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "Failed to get current location",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                                borderColor: const Color(0xFFEDEDF3),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

            ),
          ),
        )
    );
    }
}

// Single global function for getting current location
Future<Position?> getCurrentLocation() async {
  try {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        "Location Service Disabled",
        "Please enable your location services",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return null;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Permission Denied",
          "Location permission is required to find nearby stations",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Permission Required",
        "Location permissions are permanently denied. Please enable them from app settings",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    print("Current Location: ${position.latitude}, ${position.longitude}");

    return position;
  } catch (e) {
    print("Error getting location: $e");
    Get.snackbar(
      "Error",
      "Failed to get current location: $e",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    return null;
  }
}