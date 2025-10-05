import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/global_widegts/appBar.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/bottom_nav_user/screen/bottom_nav_user.dart';
import 'package:naderhosn/feature/raider/cost_calculate/controller/cost_calculate_controller.dart';

class CostCalculateLocation extends StatelessWidget {
  CostCalculateLocation({super.key});
  final CostCalculateController controller = Get.put(CostCalculateController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomAppBar(
                title: "Plan your ride ",
                onLeadingTap: () => Navigator.pop(context),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.searchPickController,
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  labelText: 'Enter pickup add location',
                  labelStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // rounded corners
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: 2,
                    ), // border color when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: 1,
                    ), // border color when focused
                  ),
                ),

                onChanged: (value) {
                  controller.searchPickPlaces(value);
                },
              ),
              Obx(() {
                if (controller.pickPredictions.isEmpty) {
                  return SizedBox();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.pickPredictions.length,
                    itemBuilder: (context, index) {
                      final prediction = controller.pickPredictions[index];
                      return ListTile(
                        title: Text(prediction['description']),
                        onTap: () {
                          controller.selectPickPlace(
                            prediction['place_id'],
                            prediction['description'],
                          );
                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: 20),
              Obx(
                () => controller.selectPickAddress.isNotEmpty
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton.icon(
                          onPressed: controller.clearPickLocation,
                          icon: Icon(Icons.clear, color: Colors.white),
                          label: Text(
                            'Clear pickup Location',
                            style: globalTextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ), // inside spacing
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Obx(() {
                            if (controller.isPickLoading.value) {
                              return Center(
                                child: Transform.scale(
                                  scale: 0.5,
                                  child: CircularProgressIndicator(
                                    color: Colors.amber,
                                  ),
                                ),
                              );
                            } else {
                              return ElevatedButton.icon(
                                onPressed: () async {
                                  await controller.useCurrentPickLocation();
                                  FocusScope.of(context).unfocus();
                                },
                                icon: Icon(
                                  Icons.my_location,
                                  color: Colors.amber,
                                ),
                                label: Text(
                                  'Use Current Location',
                                  style: globalTextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors
                                      .white, // text and icon color when pressed
                                  elevation: 0, // shadow depth
                                  side: BorderSide(
                                    color: Colors.black12,
                                    width: 1,
                                  ), // border color & width
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ), // rounded corners
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ), // inside spacing
                                ),
                              );
                            }
                          }),

                          SizedBox(height: 16),

                          // Your existing TextField and the rest...
                        ],
                      ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: controller.searchDestController,
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  labelText: 'Where to?',
                  labelStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // rounded corners
                    borderSide: BorderSide(
                      color: Colors.amber,
                      width: 2,
                    ), // border color when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 1,
                    ), // border color when focused
                  ),
                ),

                onChanged: (value) {
                  controller.searchDestPlaces(value);
                },
              ),
              Obx(() {
                if (controller.destPredictions.isEmpty) {
                  return SizedBox();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.destPredictions.length,
                    itemBuilder: (context, index) {
                      final prediction = controller.destPredictions[index];
                      return ListTile(
                        title: Text(prediction['description']),
                        onTap: () {
                          controller.selectDestPlace(
                            prediction['place_id'],
                            prediction['description'],
                          );
                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: 20),

              Obx(
                () => controller.selectDestAddress.isNotEmpty
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton.icon(
                          onPressed: controller.clearDestLocation,
                          icon: Icon(Icons.clear, color: Colors.white),
                          label: Text(
                            'Clear Location',
                            style: globalTextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ), // inside spacing
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
              Spacer(),
              Obx(
                () =>
                    controller.selectDestAddress.isNotEmpty &&
                        controller.selectPickAddress.isNotEmpty
                    ? CustomButton(
                        title: 'Done',
                        backgroundColor: const Color(0xFFFFDC71),
                        borderColor: Colors.transparent,
                        textStyle: globalTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        onPress: () {
                          Get.to(() => BottomNavbarUser());
                        },
                      )
                    : SizedBox(),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
