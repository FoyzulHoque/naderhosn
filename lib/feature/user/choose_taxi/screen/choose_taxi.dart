import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/user/choose_taxi/controler/choose_taxi_controller.dart';
import 'package:naderhosn/feature/user/confirm_pickup/screen/confirm_pickup.dart';
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
          ExpandedBottomSheet(),
        ],
      ),
    );
  }
}

class ExpandedBottomSheet extends StatelessWidget {
  const ExpandedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.24,
      minChildSize: 0.1,
      maxChildSize: 0.7,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Confirm details",
                    style: globalTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Divider(),

                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/car2.png",
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Taxi",
                      style: globalTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$186.00",
                      style: globalTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "3:09 .  6 min",
                  style: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF777F8B),
                  ),
                ),
                Text(
                  "Affordable eveyday rides",
                  style: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF777F8B),
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text(
                  "Payment method",
                  style: globalTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/card.png",
                      width: 45,
                      height: 45,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Add new card ",
                      style: globalTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_right_sharp),
                  ],
                ),
                SizedBox(height: 20),
                CustomButton(
                  title: "Choose Taxi",
                  borderColor: Colors.transparent,
                  backgroundColor: Color(0xFFFFDC71),
                  onPress: () {
                    Get.to(() => ConfirmPickUpScreen());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
