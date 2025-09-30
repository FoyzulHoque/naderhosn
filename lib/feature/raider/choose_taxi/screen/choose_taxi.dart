import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/raider/choose_taxi/controler/choose_taxi_controller.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/screen/confirm_pickup.dart';
import '../controler/choose_taxi_api_controller.dart';
import '../model/location_searching_model.dart';

class ChooseTaxiScreen extends StatelessWidget {
  final ChooseTaxiController controller = Get.put(ChooseTaxiController());

  ChooseTaxiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final String pickupAddress = args['pickup'] as String? ?? "No pickup address";
    final pickupLatArg = args['pickupLat'];
    final pickupLngArg = args['pickupLng'];
    final String dropOffAddress = args['dropOff'] as String? ?? "No dropOff address";
    final dropOffLatArg = args['dropOffLat'];
    final dropOffLngArg = args['dropOffLng'];

    final double pLat = double.tryParse(pickupLatArg?.toString() ?? '0.0') ?? 0.0;
    final double pLng = double.tryParse(pickupLngArg?.toString() ?? '0.0') ?? 0.0;
    final double dLat = double.tryParse(dropOffLatArg?.toString() ?? '0.0') ?? 0.0;
    final double dLng = double.tryParse(dropOffLngArg?.toString() ?? '0.0') ?? 0.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pLat != 0.0 || pLng != 0.0 || dLat != 0.0 || dLng != 0.0) {
        print("ChooseTaxiScreen: Calling loadAndDisplayRideData with arguments from previous screen.");
        controller.loadAndDisplayRideData(
          initialPickup: pickupAddress,
          initialDropOff: dropOffAddress,
          initialPickupLat: pLat,
          initialPickupLng: pLng,
          initialDropOffLat: dLat,
          initialDropOffLng: dLng,
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            print("Rendering GoogleMap with ${controller.markers.length} markers");
            if (controller.isLoadingMap.value || (controller.isLoadingDirections.value && controller.markers.isEmpty)) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.apiController.errorMessage.value.isNotEmpty && controller.markers.isEmpty) {
              return Center(child: Text("Error: ${controller.apiController.errorMessage.value}"));
            }

            if (controller.pickupPosition.value == null && controller.markers.isEmpty) {
              if (pLat != 0.0 || pLng != 0.0) {
                print("ChooseTaxiScreen: Displaying fallback map with arguments.");
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(pLat, pLng),
                    zoom: 15,
                  ),
                  onMapCreated: controller.onMapCreated,
                );
              }
              return const Center(child: Text("Map data could not be loaded or no ride found."));
            }

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.pickupPosition.value ??
                    LatLng(pLat != 0.0 ? pLat : 23.749341, pLng != 0.0 ? pLng : 90.437213),
                zoom: 15,
              ),
              markers: controller.markers,
              polylines: controller.polyline.value.points.isNotEmpty
                  ? {controller.polyline.value}
                  : <Polyline>{},
              onMapCreated: controller.onMapCreated,
            );
          }),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 60),
            child: Text(
              "Brothers Taxi",
              style: globalTextStyle(
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

// choose_taxi.dart (UI file)

// ... (imports and ChooseTaxiScreen class remain the same) ...

class ExpandedBottomSheet extends StatelessWidget {
  final ChooseTaxiApiController apiController = Get.find<ChooseTaxiApiController>();
  final ChooseTaxiController mainMapController = Get.find<ChooseTaxiController>();

  ExpandedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // 1. Loading State for API data
      if (apiController.isLoading.value && apiController.rideDataList.isEmpty) {
        return Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1)],
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
        );
      }

      // 2. Error State for API data
      if (apiController.errorMessage.value.isNotEmpty && apiController.rideDataList.isEmpty) {
        return Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1)],
            ),
            child: Center(
              child: Text(
                "Error fetching ride options:\n${apiController.errorMessage.value}",
                style: globalTextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }

      // 3. No Ride Plans available from API
      if (apiController.rideDataList.isEmpty) {
        return Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1)],
            ),
            child: Center(
              child: Text(
                "No ride options available at the moment.",
                style: globalTextStyle(fontSize: 16, color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }

      // --- Data is available ---
      final ridePlanFromApi = apiController.rideDataList.first; // Assuming we always work with the first ride plan

      // Get the list of available drivers for the bottom sheet
      final List<NearbyDriver> driversToShow = ridePlanFromApi.availableDrivers ?? [];

      return DraggableScrollableSheet(
        initialChildSize: 0.30,
        minChildSize: 0.15,
        maxChildSize: 0.7,
        builder: (BuildContext sheetContext, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1)],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 50, height: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Available Taxis", // Or "Choose Your Ride"
                      style: globalTextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  const SizedBox(height: 10),

                  // --- MODIFIED SECTION TO DISPLAY LIST OF AVAILABLE DRIVERS ---
                  if (driversToShow.isNotEmpty)
                    ...driversToShow.map((driver) { // 'driver' is a NearbyDriverModel object
                      // You might need to fetch fare for each driver separately if not in NearbyDriverModel
                      // For now, using the ridePlanFromApi.estimatedFare as a general fare
                      final String fareDisplay = ridePlanFromApi.estimatedFare != null
                          ? "\$${ridePlanFromApi.estimatedFare!.toStringAsFixed(2)}" // Assuming estimatedFare is for the plan
                          : "N/A"; // Or fetch price per driver type

                      // Calculate ETA (example: 2 minutes per km, min 3 mins)
                      final String etaDisplay = driver.distance != null
                          ? "Pickup: In ${(driver.distance! * 2).round().clamp(3, 60)} min"
                          : "Pickup: In 3-5 min";

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset( // Generic car image for all types for now
                              "assets/images/car2.png", // Ensure this path is correct
                              width: MediaQuery.of(sheetContext).size.width * 0.45,
                              height: 90,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_car_filled, size: 60, color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  driver.vehicleName ?? "Standard Taxi", // Use vehicleName from driver
                                  style: globalTextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                fareDisplay, // This is currently the plan's fare. Adjust if drivers have individual fares.
                                style: globalTextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            etaDisplay,
                            style: globalTextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: const Color(0xFF777F8B)),
                          ),
                          // If NearbyDriverModel had specialNotes, you could display them here
                          // if (driver.specialNotes != null && driver.specialNotes!.isNotEmpty)
                          //   Padding(...),
                          const SizedBox(height: 15),
                          CustomButton(
                            title: "Choose This Taxi",
                            borderColor: Colors.transparent, // Handled by CustomButton
                            onPress: () {
                              // IMPORTANT: Pass data related to the *selected driver* and the *ride plan*
                              Get.to(() => ConfirmPickUpScreen(), arguments: {
                                'ridePlanId': ridePlanFromApi.id,
                                'selectedDriverId': driver.id, // Pass driver's ID
                                'selectedVehicleId': driver.vehicleId, // Pass vehicle ID
                                'selectedVehicleName': driver.vehicleName,
                                'pickupAddress': ridePlanFromApi.pickup,
                                'dropOffAddress': ridePlanFromApi.dropOff,
                                "pickupDate":ridePlanFromApi.pickupDate,
                                "pickupTime":ridePlanFromApi.pickupTime,
                                // Fare might need to be recalculated or confirmed if it varies by driver/vehicle
                                'estimatedFare': ridePlanFromApi.estimatedFare, // Or a driver-specific fare
                                'driverLat': driver.lat, // For ConfirmPickUpScreen if needed
                                'driverLng': driver.lng, // For ConfirmPickUpScreen if needed
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          const Divider(), // Divider between taxi options
                        ],
                      );
                    }).toList()
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: Text(
                          "No taxis currently available for this route.",
                          style: globalTextStyle(color: Colors.grey.shade600, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  // --- END OF MODIFIED SECTION ---

                  /*const SizedBox(height: 15), // Spacing before Payment Method
                  Text(
                    "Payment Method",
                    style: globalTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      Get.snackbar("Payment", "Navigate to add/select card screen.");
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/card.png", width: 40, height: 40,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.credit_card, size: 40, color: Colors.grey),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Add New Card",
                            style: globalTextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25), */// Bottom padding
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
