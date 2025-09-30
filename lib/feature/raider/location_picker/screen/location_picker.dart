/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/global_widegts/appBar.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/raider/choose_taxi/screen/choose_taxi.dart';
import 'package:naderhosn/feature/raider/location_picker/controller/location_picker_controller.dart';

class LocationPicker extends StatelessWidget {
  LocationPicker({super.key});
  final LocationPickerController controller = Get.put(
    LocationPickerController(),
  );

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
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  labelText: '',
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 1),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto, // Fix to ensure label floats above the field
                ),
                onChanged: (value) {
                  print("Searching for: $value"); // Debug print for search
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
                        title: Text(
                          prediction['description'],
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          print("Selected prediction: ${prediction['description']}"); // Debug print
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
              // Use current location button
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(() {
                    if (controller.isPickLoading.value) {
                      return Center(
                        child: Transform.scale(
                          scale: 0.5,
                          child: CircularProgressIndicator(color: Colors.amber),
                        ),
                      );
                    } else {
                      return ElevatedButton.icon(
                        onPressed: () async {
                          await controller.useCurrentPickLocation();
                          FocusScope.of(context).unfocus();
                        },
                        icon: Icon(Icons.my_location, color: Colors.amber),
                        label: Text(
                          'Use current location',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          elevation: 0,
                          side: BorderSide(color: Colors.black12, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      );
                    }
                  }),
                  SizedBox(height: 16),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.searchDropOffController,
                cursorColor: Colors.green,
                decoration: InputDecoration(
                  labelText: '',
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 1),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto, // Fix to ensure label floats above the field
                ),
                onChanged: (value) {
                  print("Searching for: $value"); // Debug print for search
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
                        title: Text(
                          prediction['description'],
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          print("Selected prediction: ${prediction['description']}"); // Debug print
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
              // OK Button to select and navigate back
              Obx(
                    () => controller.selectPickAddress.isNotEmpty
                    ? ElevatedButton.icon(
                  onPressed: () {
                    // Pass the selected location (address, lat, and long) back to the previous screen
                      Get.to(() => ChooseTaxiScreen(),arguments: {
                        'address': controller.selectPickAddress.value, // Address
                        'lat': controller.pickLat.value, // Latitude
                        'long': controller.pickLong.value, // Longitude});
                    });
                  },
                 // icon: Icon(Icons.check, color: Colors.white),
                  label: Text(
                      'Done',
                    style: globalTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFDC71),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                )
                    : SizedBox(),
              ),
              SizedBox(height: 10),






              *//*TextField(
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.done,
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
                          Get.to(() => ChooseTaxiScreen());
                        },
                      )
                    : SizedBox(),
              ),
              SizedBox(height: 10),*//*
            ],
          ),
        ),
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Assuming these imports exist in your project
import 'package:naderhosn/core/global_widegts/appBar.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/network_caller/network_config.dart';
import 'package:naderhosn/core/services_class/data_helper.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/raider/choose_taxi/screen/choose_taxi.dart';
import 'package:naderhosn/feature/raider/location_picker/controller/location_picker_controller.dart';

import '../../../../core/network_caller/endpoints.dart';

class LocationPicker extends StatelessWidget {
  LocationPicker({super.key});
  final LocationPickerController controller = Get.put(
    LocationPickerController(),
  );

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
              const SizedBox(height: 20),

              // -----------------------------------------------------------------
              //                         PICKUP LOCATION WIDGETS
              // -----------------------------------------------------------------

              Obx(() => controller.selectPickAddress.isEmpty
                  ? Column(
                children: [
                  // --- PICKUP TEXTFIELD ---
                  TextField(
                    textInputAction: TextInputAction.next,
                    controller: controller.searchPickController,
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                      labelText: 'Enter pickup location',
                      labelStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.amber, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.amber, width: 1),
                      ),
                    ),
                    onChanged: (value) => controller.searchPickPlaces(value),
                  ),
                  // --- Use Current Location Button ---
                  const SizedBox(height: 16),
                  controller.isPickLoading.value
                      ? const Center(child: CircularProgressIndicator(color: Colors.amber, strokeWidth: 2))
                      : ElevatedButton.icon(
                    onPressed: () async {
                      await controller.useCurrentPickLocation();
                      FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(Icons.my_location, color: Colors.amber),
                    label: const Text('Use Current Location', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      side: const BorderSide(color: Colors.black12, width: 1),
                    ),
                  ),
                ],
              )
              // --- Selected Pick Address Display/Clear ---
                  : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  onPressed: controller.clearPickLocation,
                  icon: const Icon(Icons.location_on, color: Colors.amber),
                  label: Text(
                    controller.selectPickAddress.value,
                    style: globalTextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.withOpacity(0.1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: const BorderSide(color: Colors.amber),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
              )),

              // --- PICKUP PREDICTIONS LIST ---
              Obx(() {
                if (controller.pickPredictions.isEmpty) {
                  return const SizedBox();
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

              const SizedBox(height: 20),

              // -----------------------------------------------------------------
              //                       DROP-OFF LOCATION WIDGETS
              // -----------------------------------------------------------------

              Obx(() => controller.selectDropOffAddress.isEmpty
                  ? Column(
                children: [
                  // --- DROP-OFF TEXTFIELD ---
                  TextField(
                    textInputAction: TextInputAction.done,
                    controller: controller.searchDropOffController,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      labelText: 'Where to?',
                      labelStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.green, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.green, width: 1),
                      ),
                    ),
                    onChanged: (value) => controller.searchDropOffPlaces(value),
                  ),
                  // --- Use Current Location Button for Drop-Off (optional, added for completeness) ---
                  const SizedBox(height: 16),
                  /*controller.isDropOffLoading.value
                      ? const Center(child: CircularProgressIndicator(color: Colors.green, strokeWidth: 2))
                      : ElevatedButton.icon(
                    onPressed: () async {
                      await controller.useCurrentDropOffLocation();
                      FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(Icons.my_location, color: Colors.green),
                    label: const Text('Use Current Location as Drop-off', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      side: const BorderSide(color: Colors.black12, width: 1),
                    ),
                  ),*/
                ],
              )
              // --- Selected Drop-Off Address Display/Clear ---
                  : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  onPressed: controller.clearDropOffLocation,
                  icon: const Icon(Icons.location_on, color: Colors.green),
                  label: Text(
                    controller.selectDropOffAddress.value,
                    style: globalTextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(0.1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: const BorderSide(color: Colors.green),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
              )),

              // --- DROP-OFF PREDICTIONS LIST ---
              Obx(() {
                if (controller.dropOffPredictions.isEmpty) {
                  return const SizedBox();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.dropOffPredictions.length,
                    itemBuilder: (context, index) {
                      final prediction = controller.dropOffPredictions[index];
                      return ListTile(
                        title: Text(prediction['description']),
                        onTap: () {
                          controller.selectDropOffPlace(
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

              const Spacer(),

              // --- DONE/CONTINUE BUTTON ---
              Obx(
                    () => controller.selectDropOffAddress.isNotEmpty &&
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


                    locationApiCall();


                    // Navigate and pass both pick and drop-off data
                    Get.to(() => ChooseTaxiScreen(), arguments: {
                      'pickup': controller.selectPickAddress.value,
                      'pickupLat': controller.pickLat.value,
                      'pickupLng': controller.pickLong.value,
                      'dropOff': controller.selectDropOffAddress.value,
                      'dropOffLat': controller.dropOffLat.value,
                      'dropOffLng': controller.dropOffLong.value,
                    });

                  },
                )
                    : const SizedBox(),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> locationApiCall()async{
    Map<String,dynamic>mapBody={
      "pickup": controller.selectPickAddress.value,
      "dropOff": controller.selectDropOffAddress.value,
      "pickupLat": controller.pickLat.value,
      "pickupLng": controller.pickLong.value,
      "dropOffLat": controller.dropOffLat.value,
      "dropOffLng":  controller.dropOffLong.value,
    };
    
    NetworkResponse response=await NetworkCall.postRequest(url: Urls.pickUpLocation,body: mapBody);

    if(response.isSuccess){

      await AuthController.accessToken;
      print("location find success");
    }else{
      print("${response.statusCode}");
    }


}
}