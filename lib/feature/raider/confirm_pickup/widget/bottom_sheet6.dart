import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/services_class/data_helper.dart'; // Assuming AuthController is here
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../friends/screen/chat_screen.dart';
import '../controler/confirm_pickup_controller.dart';
import '../controler/driver_infor_api_controller.dart';
import '../controler/my_ride_pending_api_controller.dart';

class ExpandedBottomSheet6 extends StatefulWidget {
  const ExpandedBottomSheet6({super.key});

  @override
  State<ExpandedBottomSheet6> createState() => _ExpandedBottomSheet6State();
}

class _ExpandedBottomSheet6State extends State<ExpandedBottomSheet6> {
  // 1. Controller Initializations
  final ConfirmPickupController controller = Get.put(ConfirmPickupController());
  final DriverInfoApiController driverInfoApiController = Get.put(DriverInfoApiController());
   //final MyRidePendingApiController myRidePendingApiController=Get.find<MyRidePendingApiController>();
  // NOTE: ChooseTaxiApiController removed from here.

  String transportId = ''; // State variable to hold the ID (Car Transport ID or Rider ID)

  // ✅ FIX 1: Corrected the clearing function to reset the Rx variable in the controller.
  void clearDriverInfo() {
    // Reset the Observable variable in the controller to null or an empty model instance
    driverInfoApiController.rideData.value = null;
    driverInfoApiController.isLoading.value = false;
    transportId = ''; // Also clear the local state ID
    debugPrint("🗑️ Driver info cleared and state reset.");
  }

  @override
  void initState() {
    super.initState();
    debugPrint("🚗 ExpandedBottomSheet6 initState started...");
    controller;
    // myRidePendingApiController.myRidePendingApiController();
    // Start the process of finding the ID and fetching data
    _fetchAndLoadData();
  }

  // Consolidated async method to fetch ID from AuthController and call API safely
  void _fetchAndLoadData() async {
    String? fetchedId;

    // 1. Get ID from AuthController
    fetchedId = await AuthController.getUserId();

    if (fetchedId != null && fetchedId.isNotEmpty) {
      transportId = fetchedId; // Update the state variable (used for the initial null check in build)
      debugPrint("------Auth User ID fetched (used as transportId): $transportId");

      // Use Future.microtask to call API safely outside the current build cycle
      Future.microtask(() {
        driverInfoApiController.driverInfoApiMethod(transportId);
      });

    } else {
      debugPrint("⚠️ Auth User ID is null or empty. Cannot fetch driver info.");
    }
  }


  @override
  Widget build(BuildContext context) {
    debugPrint("🧱 ExpandedBottomSheet6 build() triggered.");

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1)],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            final rideData = driverInfoApiController.rideData.value;
            final driver = rideData?.vehicle?.driver;
            final isLoading = driverInfoApiController.isLoading.value;

            debugPrint("📡 Obx rebuild: isLoading=$isLoading, rideData=${rideData != null}");

            // The ID used for chat, typically the Car Transport ID from the fetched rideData
            final String idForChat = rideData?.id ?? transportId;

            final pickupTime = rideData?.pickupTime != null
                ? "Pickup at ${rideData!.pickupTime}"
                : "Pickup time not available";

            final imageUrl = (driver?.profileImage != null && driver!.profileImage!.isNotEmpty)
                ? (driver.profileImage!.startsWith('http')
                ? driver.profileImage!
                : 'https://brother-taxi.onrender.com${driver.profileImage!}')
                : null;

            // Check if loading failed and no ID was available
            if (!isLoading && rideData == null && transportId.isEmpty) {
              debugPrint("❌ rideData is null and no transportId available!");
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    "Failed to load ride data. Please try again.",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ),
              );
            }

            if (isLoading && rideData == null) {
              debugPrint("⏳ Loading driver info from API...");
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== Top Handle Bar =====
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

                  // ===== Pickup Time and Ride Info Sections (No Change) =====
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      pickupTime,
                      style: globalTextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFB),
                      border: Border.all(width: 1, color: const Color(0xFFEDEDF3)),
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
                                  color: const Color(0xFF041023),
                                ),
                              ),
                              const SizedBox(height: 5),
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
                              debugPrint("🧭 Option button tapped - switching sheet index.");
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

                  const SizedBox(height: 20),

                  // ===== Driver Info Section (No Change) =====
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFB),
                      border: Border.all(width: 1, color: const Color(0xFFEDEDF3)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: isLoading && rideData == null
                        ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                        : Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: imageUrl != null
                                  ? Image.network(
                                imageUrl,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const CircularProgressIndicator();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  debugPrint("❌ Error loading driver image: $error");
                                  return Image.asset(
                                    'assets/images/Ellipse 459 (2).png',
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                                  : Image.asset(
                                'assets/images/Ellipse 459 (2).png',
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    driver?.fullName ?? "Unknown Driver",
                                    overflow: TextOverflow.ellipsis,
                                    style: globalTextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, size: 18, color: Colors.amber),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          "${driver?.averageRating?.toStringAsFixed(1) ?? 'N/A'} (${driver?.reviewCount ?? 0} reviews)",
                                          overflow: TextOverflow.ellipsis,
                                          style: globalTextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF454F60),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              "assets/images/car2.png",
                              height: 40,
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== Chat & Call Buttons Section (No Change) =====
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.chat_bubble_outline),
                          label: const Text("Chat"),
                          onPressed: () {
                            debugPrint("💬 Chat tapped - idForChat=$idForChat");
                            if (idForChat.isNotEmpty) {
                              Get.to(() => ChatScreen(carTransportId: idForChat));
                            } else {
                              Get.snackbar("Error", "Ride ID is not available for chat.");
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () async {
                          final phone = driver?.phoneNumber;
                          debugPrint("📞 Attempting to call: $phone");
                          if (phone == null || phone.isEmpty) {
                            Get.snackbar("Error", "Driver's phone number is not available.");
                            return;
                          }
                          final uri = Uri.parse("tel:$phone");
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            debugPrint("❌ Could not open dialer for: $phone");
                            Get.snackbar("Error", "Could not open the phone dialer.");
                          }
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

                  const SizedBox(height: 20),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}