import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/controler/confirm_pickup_controller.dart';
import 'package:url_launcher/url_launcher.dart' show launch;

import '../../../friends/screen/chat_screen.dart';


class ExpandedBottomSheet6 extends StatelessWidget {
  ExpandedBottomSheet6({super.key});

  final ConfirmPickupController controller = Get.put(ConfirmPickupController());

  final String carTransportId = "68dac36a9d6556e4d3aa05eb";

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
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
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Pickup in 7 min",
                    style: globalTextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFB),
                    border: Border.all(width: 1, color: Color(0xFFEDEDF3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ride details",
                              style: globalTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF041023),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Meet at the pickup point",
                              style: globalTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            controller.changeSheet(5);
                          },
                          child: Image.asset(
                            "assets/images/option_button.png",
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFB),
                    border: Border.all(width: 1, color: Color(0xFFEDEDF3)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/profile.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sabuj Mia",
                                style: globalTextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star_border),
                                  Text(
                                    "4.5 (125 review)",
                                    style: globalTextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF454F60),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Image.asset(
                            "assets/images/car2.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(
                              "DHM-TAW-118766",
                              style: globalTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          Flexible(
                            flex: 1,
                            child: Text(
                              "2000",
                              style: globalTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Text(
                              "Blue Bajaj taxi",
                              style: globalTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF454F60),
                              ),
                            ),
                          ),

                          Flexible(
                            flex: 2,
                            child: Text(
                              "Ride complete",
                              style: globalTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFf454F60),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.chat_bubble_outline),
                        label: const Text("Chat"),
                        onPressed: () {
                          Get.to(ChatScreen(carTransportId: carTransportId));
                        },
                      ),
                    ),
                    SizedBox(width: 15),

                    GestureDetector(
                      onTap: () async {
                        final phone = "44";
                        launch("tel://+${phone}");
                      },
                      child: Image.asset(
                        "assets/images/call.png",
                        height: 60,
                        width: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
