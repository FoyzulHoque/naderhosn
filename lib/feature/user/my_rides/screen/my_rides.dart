import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/global_widegts/appBar.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/user/my_rides/controller/my_rides_controller.dart';

import '../widget/ride_history_tab2.dart';
import '../widget/ride_history_tap.dart';

class MyRides extends StatelessWidget {
  MyRides({super.key});

  final MyRidesController controller = Get.put(MyRidesController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: controller.currentTabIndex.value,
      child: Builder(
        builder: (context) {
          final tabController = DefaultTabController.of(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomAppBar(
                      title: "",
                      onLeadingTap: () {
                        Get.back();
                      },
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "My rides ",
                        style: globalTextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF212529),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFF2F2F2),
                      ),
                      child: ButtonsTabBar(
                        backgroundColor: Color(0xFFFFDC71),
                        unselectedBackgroundColor: Colors.white,
                        unselectedLabelStyle: TextStyle(
                          color: Color(0xFF4D5154),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 0,
                        ),
                        buttonMargin: EdgeInsets.symmetric(horizontal: 10),
                        radius: 30,
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: [
                          Tab(text: "My rides"),
                          Tab(text: "Ride History"),
                          // Tab(text: "Canceled"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          RideHistoryTab(
                            imagePersion: "assets/icons/user (2).png",
                            textPersion: "Justin Westervelt",
                            imagelocation1: "assets/icons/Frame.png",
                            textlocation1: "El-Baght Food Resmourants",
                            imagelocation2: "assets/icons/location-08 (4).png",
                            textlocation2: "El-Baght Food Resmourants",
                            pricing: "120",
                          ),

                          RideHistoryTab2(
                            buttonColor: Color(0xFFFFDC71),
                            buttonText:"Done (2-2-21" ,
                            widget: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: RideHistoryTab(
                                imagePersion: "assets/icons/user (2).png",
                                textPersion: "Justin Westervelt",
                                imagelocation1: "assets/icons/Frame.png",
                                textlocation1: "El-Baght Food Restaurants",
                                imagelocation2: "assets/icons/location-08 (4).png",
                                textlocation2: "Downtown City Mall",
                                pricing: "25.50",
                              ),
                            ),
                          )],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}




