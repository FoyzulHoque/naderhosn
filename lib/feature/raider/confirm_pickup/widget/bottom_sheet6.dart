import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:naderhosn/core/services_class/data_helper.dart'; // Assuming AuthController is here
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../friends/screen/chat_screen.dart';
import '../controler/confirm_pickup_controller.dart';
import '../controler/driver_infor_api_controller.dart';

class ExpandedBottomSheet6 extends StatefulWidget {
  const ExpandedBottomSheet6({super.key});

  @override
  State<ExpandedBottomSheet6> createState() => _ExpandedBottomSheet6State();
}

class _ExpandedBottomSheet6State extends State<ExpandedBottomSheet6> {
  // 1. Controller Initializations
  final ConfirmPickupController controller = Get.put(ConfirmPickupController());
  final DriverInfoApiController driverInfoApiController = Get.put(DriverInfoApiController());
  //final MyRidePendingApiController myRidePendingApiController = Get.put(MyRidePendingApiController());

  String transportId = ''; // State variable to hold the ID (Car Transport ID or Rider ID)

  // Clear driver info function
  void clearDriverInfo() {
    // Reset the Observable variable in the controller to null or an empty model instance
    driverInfoApiController.rideData.value = null;
    driverInfoApiController.isLoading.value = false;
    transportId = ''; // Also clear the local state ID
    AuthController.idClear();
    debugPrint("🗑️ Driver info cleared and state reset.");
  }

  @override
  void initState() {
    super.initState();
    debugPrint("🚗 ExpandedBottomSheet6 initState started...");
    controller; // Keep controller initialization
    // Start the process of fetching data
    _fetchAndLoadData();
  }

  // Consolidated async method to fetch ID and call APIs in sequence
  void _fetchAndLoadData() async {
    try {
      // 1. Call MyRidePendingApiController first
      debugPrint("📡 [API] Starting MyRidePendingApiController call...");
      // await myRidePendingApiController.myRidePendingApiController();
      debugPrint("✅ [API] MyRidePendingApiController call completed.");

      // 2. Get ID from AuthController after the first API call
      debugPrint("🔍 [Auth] Fetching user ID from AuthController...");
      String? fetchedId = await AuthController.getUserId();
      debugPrint("✅ [Auth] User ID fetch completed: fetchedId=$fetchedId");

      if (fetchedId != null && fetchedId.isNotEmpty) {
        transportId = fetchedId; // Update the state variable
        debugPrint("📌 [State] transportId updated: $transportId");

        // 3. Call DriverInfoApiController only after the above steps
        Future.microtask(() {
          debugPrint("📡 [API] Starting DriverInfoApiController call with transportId: $transportId");
          driverInfoApiController.driverInfoApiMethod(transportId);
        });
      } else {
        debugPrint("⚠️ [Error] Auth User ID is null or empty. Cannot fetch driver info.");
        Get.snackbar("Error", "User ID not available. Cannot fetch driver info.");
      }
    } catch (e, stackTrace) {
      debugPrint("❌ [Error] Exception in _fetchAndLoadData: $e");
      debugPrint("📜 [StackTrace] $stackTrace");
      Get.snackbar("Error", "Failed to load data: $e");
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
            final vehicle = rideData?.vehicle;
            final isLoading = driverInfoApiController.isLoading.value;

            debugPrint("📡 [Obx] Rebuild triggered: isLoading=$isLoading, rideData=${rideData != null}");

            // The ID used for chat, typically the Car Transport ID from the fetched rideData
            final String idForChat = rideData?.id ?? transportId;

            // Helper function
            String formatPickupTime(String time24) {
              try {
                final parsedTime = DateFormat("HH:mm").parse(time24);
                return DateFormat.jm().format(parsedTime); // 12-hour format
              } catch (e) {
                return time24; // Return original time if parsing fails
              }
            }

            // pickupTime variable
            final pickupTime = rideData?.pickupTime != null
                ? "Pickup at ${formatPickupTime(rideData!.pickupTime!)}"
                : "Pickup time not available";

            final imageUrl = (driver?.profileImage != null && driver!.profileImage!.isNotEmpty)
                ? (driver.profileImage!.startsWith('http')
                ? driver.profileImage!
                : 'https://brother-taxi.onrender.com${driver.profileImage!}')
                : null;

            // Check if loading failed and no ID was available
            if (!isLoading && rideData == null && transportId.isEmpty) {
              debugPrint("❌ [UI] rideData is null and no transportId available!");
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
              debugPrint("⏳ [UI] Loading driver info from API...");
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

                  // ===== Pickup Time and Ride Info Sections =====
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
                              debugPrint("🧭 [Action] Option button tapped - switching sheet index.");
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

                  // ===== Driver Info Section =====
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
                                  debugPrint("❌ [Image] Error loading driver image: $error");
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
                            Image.network(
                              "${vehicle?.image ?? "assets/images/car2.png"}",
                              height: 80,
                              width: 160,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== Chat & Call Buttons Section =====
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
                            debugPrint("💬 [Action] Chat tapped - idForChat=$idForChat");
                            if (idForChat.isNotEmpty) {
                              Get.to(() => ChatScreen(carTransportId: idForChat));
                            } else {
                              debugPrint("❌ [Error] Chat failed: Ride ID not available.");
                              Get.snackbar("Error", "Ride ID is not available for chat.");
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () async {
                          final phone = driver?.phoneNumber;
                          debugPrint("📞 [Action] Attempting to call: $phone");
                          if (phone == null || phone.isEmpty) {
                            debugPrint("❌ [Error] Call failed: Driver's phone number not available.");
                            Get.snackbar("Error", "Driver's phone number is not available.");
                            return;
                          }
                          final uri = Uri.parse("tel:$phone");
                          if (await canLaunchUrl(uri)) {
                            debugPrint("✅ [Action] Launching phone dialer: $phone");
                            await launchUrl(uri);
                          } else {
                            debugPrint("❌ [Error] Could not open dialer for: $phone");
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