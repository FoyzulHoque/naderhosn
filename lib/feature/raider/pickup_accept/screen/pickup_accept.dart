import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/widget/bottom_sheet6.dart';
import 'package:naderhosn/feature/raider/pickup_accept/controler/pickup_accept_controller.dart';

class PickupAcceptScreen extends StatelessWidget {
  final PickupAcceptController controllerPickupAccept = Get.put(
    PickupAcceptController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return controllerPickupAccept.isLoading.value
                ? const Center(
              child: CircularProgressIndicator(),
            ) // Added Center for better display
                : GoogleMap(
              initialCameraPosition: CameraPosition(
                // Use the observable position
                target: controllerPickupAccept.markerPosition.value,
                zoom: 11,
              ),
              // Use the observable set of markers
              markers: controllerPickupAccept.markers.value,
              polylines: {
                // Use the observable polyline
                controllerPickupAccept.polyline.value,
              },
            );

                    child: CircularProgressIndicator(),
                  ) // Added Center for better display
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      // Use the observable position
                      target: controllerPickupAccept.markerPosition.value,
                      zoom: 11,
                    ),
                    // Use the observable set of markers
                    markers: controllerPickupAccept.markers.value,
                    polylines: {
                      // Use the observable polyline
                      controllerPickupAccept.polyline.value,
                    },
                  );
          }),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 60),
            child: Text(
              "Brothers Taxi",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          ExpandedBottomSheet6(),
        ],
      ),
    );
  }
}