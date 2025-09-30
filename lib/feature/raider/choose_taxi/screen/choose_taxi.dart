import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/raider/choose_taxi/controler/choose_taxi_controller.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/screen/confirm_pickup.dart';

import '../controler/choose_taxi_api_controller.dart';

// Assuming globalTextStyle is defined elsewhere

class ChooseTaxiScreen extends StatelessWidget {
  final ChooseTaxiController controller = Get.put(ChooseTaxiController());

  @override
  Widget build(BuildContext context) {
    // 🔹 Receive arguments from previous screen
    final args = Get.arguments ?? {};
    final pickup = args['pickup'] ?? "No pickup";
    final pickupLatArg = args['pickupLat'];
    final pickupLngArg = args['pickupLng'];
    final dropOff = args['dropOff'] ?? "No dropOff";
    final dropOffLatArg = args['dropOffLat'];
    final dropOffLngArg = args['dropOffLng'];

    // Convert to double safely
    final double pLat = double.tryParse(pickupLatArg.toString()) ?? 0.0;
    final double pLng = double.tryParse(pickupLngArg.toString()) ?? 0.0;
    final double dLat = double.tryParse(dropOffLatArg.toString()) ?? 0.0;
    final double dLng = double.tryParse(dropOffLngArg.toString()) ?? 0.0;

    // 💡 FIX: Call the loading method here after arguments are available
    // Ensures controller receives LatLng data before API call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only load if data hasn't been loaded yet
      if (controller.markerPosition.value == null && !controller.isLoading.value) {
        controller.loadRideData(
            pLat: pLat,
            pLng: pLng,
            dLat: dLat,
            dLng: dLng
        );
      }
    });


    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            // 1. Loading State
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. Failure State (markerPosition is null after loading)
            if (controller.markerPosition.value == null) {
              // Show a fallback map centered on the received pickup point if valid,
              // otherwise show an error message.
              if (pLat != 0.0 || pLng != 0.0) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(pLat, pLng),
                    zoom: 15,
                  ),
                  // No markers/polylines loaded from API will be shown here
                );
              }
              return const Center(child: Text("Map data could not be loaded."));
            }

            // 3. Success State (Map is ready)
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                // ✅ FIX: Use the null assertion operator '!'
                target: controller.markerPosition.value!,
                zoom: 15,
              ),

              // Markers (Pickup, Dropoff, and Nearby Cars)
              markers: controller.markers.value,

              // Polyline between Pickup and Dropoff
              polylines: {
                controller.polyline.value,
              },
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
          // 🔹 Show pickup/dropOff data on screen (Uncommented for utility)
          ExpandedBottomSheet(),
        ],
      ),
    );
  }
}
class ExpandedBottomSheet extends StatelessWidget {
  ExpandedBottomSheet({super.key});

  final ChooseTaxiApiController controller2 =
  Get.put(ChooseTaxiApiController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller2.rideDataList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      final data = controller2.rideDataList.first;
      final data2 =
      data.carTransport != null && data.carTransport!.isNotEmpty
          ? data.carTransport!.first
          : null;

      return DraggableScrollableSheet(
        initialChildSize: 0.24,
        minChildSize: 0.1,
        maxChildSize: 0.7,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 10, spreadRadius: 1),
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
                  const Divider(),
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
                        data2 != null ? "\$${data2.totalAmount}" : "--",
                        style: globalTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    data2?.pickupTime ?? "--",
                    style: globalTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF777F8B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Text(
                    "Payment method",
                    style: globalTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/card.png",
                        width: 45,
                        height: 45,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Add new card ",
                        style: globalTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_right_sharp),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: "Choose Taxi",
                    borderColor: Colors.transparent,
                    backgroundColor: const Color(0xFFFFDC71),
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
    });
  }
}

