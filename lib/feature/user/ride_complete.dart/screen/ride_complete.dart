import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/bottom_nav_user/screen/bottom_nav_user.dart';
import 'package:naderhosn/feature/user/ride_complete.dart/controller/ride_controller.dart';

class RideCompletedScreen extends StatelessWidget {
  final RideCompletedController controller = Get.put(RideCompletedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Check mark icon
                Center(
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100,
                  ),
                ),
                SizedBox(height: 16),

                // Ride completed text
                Center(
                  child: Text(
                    "Ride Completed",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    "Cancelling travel plans or not being \nable to go somewhere?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),

                // Rider name and trip details
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Color(0xFFF0F0F0)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(
                          'assets/images/profile.png',
                        ), // Add your image asset here
                      ),
                      SizedBox(width: 10),
                      Text(
                        controller.rideDetails.value.riderName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // Trip Details section
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Color(0xFFF0F0F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trip Details",
                        style: globalTextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF777F8B),
                        ),
                      ),
                      Text(
                        "${controller.rideDetails.value.tripDistance} (${controller.rideDetails.value.tripDuration})",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Color(0xFFF0F0F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First row
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ), // Location icon
                          SizedBox(width: 10), // Space between icon and text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter pickup add location',
                                style: globalTextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF777F8B),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Meet at the pick-up point for \nRode No.12, North',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.share_location,
                            color: Colors.black,
                          ), // Location icon
                          SizedBox(width: 10), // Space between icon and text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter destination add location',
                                style: globalTextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF777F8B),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Washing tone DC',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ride Cost",
                      style: globalTextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "\$${controller.rideDetails.value.rideCost}",
                      style: globalTextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment method",
                      style: globalTextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${controller.rideDetails.value.paymentMethod}",
                      style: globalTextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ride Type",
                      style: globalTextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${controller.rideDetails.value.rideType}",
                      style: globalTextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Booking ID",
                      style: globalTextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${controller.rideDetails.value.bookingId}",
                      style: globalTextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ride Completed on",
                      style: globalTextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      " ${controller.rideDetails.value.rideCompletedOn}",
                      style: globalTextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                CustomButton(
                  title: "Home",
                  borderColor: Colors.transparent,
                  textStyle: globalTextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Color(0xFFFFDC71),
                  onPress: () {
                    Get.to(() => BottomNavbarUser());
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
