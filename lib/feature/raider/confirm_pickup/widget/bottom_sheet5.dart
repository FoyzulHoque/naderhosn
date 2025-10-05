/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/bottom_nav_user/screen/bottom_nav_user.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/controler/confirm_pickup_controller.dart';

import '../../choose_taxi/controler/choose_taxi_api_controller.dart';
import '../controler/ride_cancel_api_controller.dart';
import 'bottom_sheet4.dart';

class ExpandedBottomSheet5 extends StatefulWidget {
  ExpandedBottomSheet5({super.key});

  @override
  State<ExpandedBottomSheet5> createState() => _ExpandedBottomSheet5State();
}

class _ExpandedBottomSheet5State extends State<ExpandedBottomSheet5> {
  final ConfirmPickupController controller = Get.put(ConfirmPickupController());

final RideCancelApiController rideCancelApiController=Get.put(RideCancelApiController());

  final ChooseTaxiApiController apiController = Get.find<ChooseTaxiApiController>();
@override
  void initState() {
  String transportId = '';

  // 1. Try to get ID from the primary controller (ChooseTaxiApiController)
  if (apiController.rideDataList.isNotEmpty &&
      apiController.rideDataList[0].carTransport != null &&
      apiController.rideDataList[0].carTransport!.isNotEmpty) {
    transportId = apiController.rideDataList[0].carTransport![0].id ?? '';
  }

  // 2. Fallback: Try to get ID from Get.arguments
  if (transportId.isEmpty) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    transportId = args['transportId']?.toString() ?? '';
    print("------ExpandedBottomSheet6 initState: transportId from arguments: $transportId");
  }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.1,
      maxChildSize: 0.5,
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
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    GestureDetector(
                      onTap: _rideCancelledMethod,
                      child: Text(
                        "Cancel trip?",
                        style: globalTextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.changeSheet(2),
                      child: Icon(Icons.close, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text(
                  "Why do you want to cancel? ",
                  style: globalTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "This trip is being offered to a driver right now and should be confirmed within seconds.",
                  style: globalTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25),
                CustomButton(
                  title: "Cancel request ",
                  borderColor: Colors.transparent,
                  backgroundColor: Color(0xFFF1F1F1),
                  textStyle: globalTextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  onPress: () {
                    Get.to(() => BottomNavbarUser());
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  title: "Wait for driver ",
                  borderColor: Colors.transparent,
                  textStyle: globalTextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Color(0xFFFFDC71),
                  onPress: () {
                    controller.selectContainerEffect(0);

                    controller.changeSheet(2);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

 Future<void> _rideCancelledMethod() async{

  Get.to(ExpandedBottomSheet4());
    */
/*String transportId = '';

    // 1. Try to get ID from the primary controller (ChooseTaxiApiController)
    if (apiController.rideDataList.isNotEmpty &&
        apiController.rideDataList[0].carTransport != null &&
        apiController.rideDataList[0].carTransport!.isNotEmpty) {
      transportId = apiController.rideDataList[0].carTransport![0].id ?? '';
    }

    // 2. Fallback: Try to get ID from Get.arguments
    if (transportId.isEmpty) {
      final args = Get.arguments as Map<String, dynamic>? ?? {};
      transportId = args['transportId']?.toString() ?? '';
    }

    if (transportId.isNotEmpty) {
      debugPrint("ExpandedBottomSheet6 initState: Calling API with ID: $transportId");
      bool isSuccess=await rideCancelApiController.rideCancelApiMethod(transportId);
      if(isSuccess){
        Get.to(() => BottomNavbarUser());
      }
    } else {
      debugPrint("⚠️ ExpandedBottomSheet6: No transport ID found - skipping API call in initState");
    }*//*

  }
}
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/bottom_nav_user/screen/bottom_nav_user.dart';

import '../controler/confirm_pickup_controller.dart';

class ExpandedBottomSheet5 extends StatelessWidget {
  ExpandedBottomSheet5({super.key});

  final ConfirmPickupController controller = Get.put(ConfirmPickupController());

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.1,
      maxChildSize: 0.5,
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
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      "Cancel trip?",
                      style: globalTextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.changeSheet(2),
                      child: Icon(Icons.close, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text(
                  "Why do you want to cancel? ",
                  style: globalTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "This trip is being offered to a driver right now and should be confirmed within seconds.",
                  style: globalTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25),
                CustomButton(
                  title: "Cancel request ",
                  borderColor: Colors.transparent,
                  backgroundColor: Color(0xFFF1F1F1),
                  textStyle: globalTextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  onPress: () {
                    Get.to(() => BottomNavbarUser());
                  },
                ),
                SizedBox(height: 10),
                CustomButton(
                  title: "Wait for driver ",
                  borderColor: Colors.transparent,
                  textStyle: globalTextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Color(0xFFFFDC71),
                  onPress: () {
                    controller.selectContainerEffect(0);

                    controller.changeSheet(2);
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