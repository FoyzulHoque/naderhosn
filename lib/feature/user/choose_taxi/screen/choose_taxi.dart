import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naderhosn/feature/user/choose_taxi/controler/choose_taxi_controller.dart';
import 'package:naderhosn/feature/user/home/controller/home_controller.dart';

class ChooseTaxiScreen extends StatelessWidget {
  final ChooseTaxiController controller = Get.put(ChooseTaxiController());

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
                      zoom: 16,
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
        ],
      ),
    );
  }
}
