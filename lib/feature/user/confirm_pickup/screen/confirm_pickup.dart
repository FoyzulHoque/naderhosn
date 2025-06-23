import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/user/choose_taxi/controler/choose_taxi_controller.dart';
import 'package:naderhosn/feature/user/confirm_pickup/controler/confirm_pickup_controller.dart';
import 'package:naderhosn/feature/user/confirm_pickup/widget/bottom_sheet1.dart';
import 'package:naderhosn/feature/user/confirm_pickup/widget/bottom_sheet2.dart';
import 'package:naderhosn/feature/user/confirm_pickup/widget/bottom_sheet3.dart';
import 'package:naderhosn/feature/user/confirm_pickup/widget/bottom_sheet4.dart';
import 'package:naderhosn/feature/user/confirm_pickup/widget/bottom_sheet5.dart';
import 'package:naderhosn/feature/user/home/controller/home_controller.dart';

class ConfirmPickUpScreen extends StatelessWidget {
  final ConfirmPickupController controller = Get.put(ConfirmPickupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return controller.isLoading.value
                ? CircularProgressIndicator()
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: controller.markerPosition.value,
                      zoom: 15,
                    ),
                    markers: controller.markers.value,
                    polylines: {
                      controller.polyline.value,
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
          Obx(() => buildBottomSheet(controller.currentBottomSheet.value)),
        ],
      ),
    );
  }

  Widget buildBottomSheet(int value) {
    switch (value) {
      case 1:
        return ExpandedBottomSheet1();
      case 2:
        return ExpandedBottomSheet2();
      case 3:
        return ExpandedBottomSheet3();
      case 4:
        return ExpandedBottomSheet4();
      case 5:
        return ExpandedBottomSheet5();
      default:
        return Container();
    }
  }
}
