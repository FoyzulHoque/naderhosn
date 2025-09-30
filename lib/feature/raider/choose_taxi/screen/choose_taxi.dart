import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/raider/choose_taxi/controler/choose_taxi_controller.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/screen/confirm_pickup.dart';
import '../controler/choose_taxi_api_controller.dart';


class ChooseTaxiScreen extends StatelessWidget {
  // The correct initialization line, assuming external cleanup is done.
  final DeliveryMapController controller = Get.put(DeliveryMapController());

  @override
  Widget build(BuildContext context) {
    // 🔹 Receive arguments from previous screen (Remains unused by new map logic)
    final args = Get.arguments ?? {};
    final pickup = args['pickup'] ?? "No pickup";
    final pickupLatArg = args['pickupLat'];
    final pickupLngArg = args['pickupLng'];
    final dropOff = args['dropOff'] ?? "No dropOff";
    final dropOffLatArg = args['dropOffLat'];
    final dropOffLngArg = args['dropOffLng'];

    // Convert to double safely (Remains unused by new map logic)
    final double pLat = double.tryParse(pickupLatArg.toString()) ?? 0.0;
    final double pLng = double.tryParse(pickupLngArg.toString()) ?? 0.0;
    final double dLat = double.tryParse(dropOffLatArg.toString()) ?? 0.0;
    final double dLng = double.tryParse(dropOffLngArg.toString()) ?? 0.0;

    // NOTE: The old API arguments are ignored by the new DeliveryMapController's map setup.

    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            // Check if map data is ready after async icon loading.
           /* if (controller.markers.value.isEmpty || controller.polylines.value.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }*/

            // Use the controller's fixed pickup location for initial map center.
            final LatLng initialTarget = controller.pickupLocation;

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initialTarget,
                zoom: 15,
              ),
              markers: controller.markers.value,
              polylines: controller.polylines.value,
              onMapCreated: (GoogleMapController mapController) {
                controller.mapController = mapController;
              },
            );
          }),

          // Header Text
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
          // NOTE: ExpandedBottomSheet still relies on ChooseTaxiApiController
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
      // Ensure the bottom sheet can handle the loading state from its own controller
      if (controller2.rideDataList.isEmpty) {
        // Show a loading indicator at the bottom
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            color: Colors.white,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),
        );
      }

      final data = controller2.rideDataList.first;

      // Data will be null if the API response is missing the 'carTransport' array/field.
      final data2 = data.carTransport != null && data.carTransport!.isNotEmpty
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
                    // NOTE: Ensure this asset path is correct
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
                        // ✅ FIX: Safely access totalAmount and explicitly convert to String
                        data2 != null
                            ? "\$${data2.totalAmount?.toString() ?? '--'}"
                            : "--",
                        style: globalTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    // ✅ FIX: Safely access pickupTime and use toString() for robustness
                    data2?.pickupTime?.toString() ?? "--",
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
                      // NOTE: Ensure this asset path is correct
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
