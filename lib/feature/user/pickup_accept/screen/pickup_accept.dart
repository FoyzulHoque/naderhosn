import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/user/confirm_pickup/controler/confirm_pickup_controller.dart';
import 'package:naderhosn/feature/user/confirm_pickup/widget/bottom_sheet5.dart';
import 'package:naderhosn/feature/user/confirm_pickup/widget/bottom_sheet6.dart';
import 'package:naderhosn/feature/user/home/controller/home_controller.dart';
import 'package:naderhosn/feature/user/pickup_accept/controler/pickup_accept_controller.dart';
import 'package:url_launcher/url_launcher.dart';

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
                ? CircularProgressIndicator()
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: controllerPickupAccept.markerPosition.value,
                      zoom: 15,
                    ),
                    markers: controllerPickupAccept.markers.value,
                    polylines: {
                      controllerPickupAccept.polyline.value,
                    }, // Show polyline between markers
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
