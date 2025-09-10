import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naderhosn/core/global_widegts/appBar.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/raider/my_rides/controller/my_rides_controller.dart';

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
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "My rides ",
                        style: globalTextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF212529),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFFF2F2F2),
                      ),
                      child: ButtonsTabBar(
                        backgroundColor: const Color(0xFFFFDC71),
                        unselectedBackgroundColor: Colors.white,
                        unselectedLabelStyle: const TextStyle(
                          color: Color(0xFF4D5154),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 0,
                        ),
                        buttonMargin: const EdgeInsets.symmetric(horizontal: 10),
                        radius: 30,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: const [
                          Tab(text: "My rides"),
                          Tab(text: "Ride History"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return RideHistoryTab(
                                imagePersion: "assets/icons/raider (2).png",
                                textPersion: "Justin Westervelt",
                                imagelocation1: "assets/icons/Frame.png",
                                textlocation1: "El-Baght Food Resmourants",
                                imagelocation2: "assets/icons/location-08 (4).png",
                                textlocation2: "El-Baght Food Resmourants",
                                pricing: "120",
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return RideHistoryTab2(
                                buttonColor: const Color(0xFFFFDC71),
                                buttonText: "Done (2-2-21)",
                                googleMapChild: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: GoogleMap(
                                        initialCameraPosition: const CameraPosition(
                                          target: LatLng(23.8103, 90.4125),
                                          zoom: 14,
                                        ),
                                        zoomControlsEnabled: false,
                                        scrollGesturesEnabled: false,
                                        zoomGesturesEnabled: false,
                                      ),
                                    ),
                                  ],
                                ),
                                widget: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: RideHistoryTab(
                                    imagePersion: "assets/icons/raider (2).png",
                                    textPersion: "Justin Westervelt",
                                    imagelocation1: "assets/icons/Frame.png",
                                    textlocation1: "El-Baght Food Restaurants",
                                    imagelocation2: "assets/icons/location-08 (4).png",
                                    textlocation2: "Downtown City Mall",
                                    pricing: "25.50",
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
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
