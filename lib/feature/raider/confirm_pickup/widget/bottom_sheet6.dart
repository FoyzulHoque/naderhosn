import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../friends/screen/chat_screen.dart';
import '../../choose_taxi/controler/choose_taxi_api_controller.dart';
import '../controler/confirm_pickup_controller.dart';
import '../controler/driver_infor_api_controller.dart';

class ExpandedBottomSheet6 extends StatefulWidget {
  const ExpandedBottomSheet6({super.key});

  @override
  State<ExpandedBottomSheet6> createState() => _ExpandedBottomSheet6State();
}

class _ExpandedBottomSheet6State extends State<ExpandedBottomSheet6> {
  final ConfirmPickupController controller = Get.put(ConfirmPickupController());
  final DriverInfoApiController driverInfoApiController = Get.put(DriverInfoApiController());

  final ChooseTaxiApiController apiController = Get.find<ChooseTaxiApiController>();


  @override
  void initState() {
    super.initState();
    String transportId = '';

    // 1. Try to get ID from the primary controller (ChooseTaxiApiController)
    if (apiController.rideDataList.isNotEmpty &&
        apiController.rideDataList[0].carTransport != null &&
        apiController.rideDataList[0].carTransport!.isNotEmpty) {
      transportId = apiController.rideDataList[0].carTransport![0].id ?? '';
    }

    // 2. Fallback: Try to get ID from Get.arguments
    if (transportId.isEmpty) {
      final args = Get.arguments as Map<String, dynamic>? ?? {};
      transportId = args['transportId']?.toString() ?? '';
    }

    if (transportId.isNotEmpty) {
      debugPrint("ExpandedBottomSheet6 initState: Calling API with ID: $transportId");
      driverInfoApiController.driverInfoApiMethod(transportId);
    } else {
      debugPrint("⚠️ ExpandedBottomSheet6: No transport ID found - skipping API call in initState");
    }
  }

  @override
  Widget build(BuildContext context) {
    // 💡 NOTE: The logic to fetch data based on arguments is now exclusively in initState.
    // We only retrieve the current ID from the controller's data for button actions.

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            final rideData = driverInfoApiController.rideData.value;
            // ✅ FIX: Use rideData?.vehicle?.driver based on API structure
            final driver = rideData?.vehicle?.driver;
            final vehicle = rideData?.vehicle;
            final isLoading = driverInfoApiController.isLoading.value;

            // Get the current ID for the Chat/Call buttons
            final String carTransportId = rideData?.id ?? '';

            final imageUrl = (driver?.profileImage != null && driver!.profileImage!.isNotEmpty)
                ? (driver.profileImage!.startsWith('http')
                ? driver.profileImage!
                : 'https://brother-taxi.onrender.com${driver.profileImage!}')
                : null;

            return SingleChildScrollView(
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
                      "Pickup in 7 min", // TODO: Make dynamic based on rideData
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
                            onTap: () => controller.changeSheet(5),
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
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFB),
                      border: Border.all(width: 1, color: const Color(0xFFEDEDF3)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: isLoading
                        ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                        : Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min, // Prevent Row from taking full width
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: imageUrl != null
                                  ? Image.network(
                                imageUrl,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Fallback to local asset if network image fails
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
                              height: 40, // Reduced size to prevent overflow
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${vehicle?.manufacturer ?? ''} ${vehicle?.model ?? ''}".trim(),
                              style: globalTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "${driver?.totalTrips}".trim(),
                                overflow: TextOverflow.ellipsis,
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
                            Text(
                              "${vehicle?.manufacturer ?? ''} ${vehicle?.model ?? ''}".trim(),
                              style: globalTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF454F60),
                              ),
                            ),
                            Text(
                              "Ride in progress",
                              style: globalTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF454F60),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
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
                            if (carTransportId.isNotEmpty) {
                              Get.to(() => ChatScreen(carTransportId: carTransportId));
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
                          if (phone == null || phone.isEmpty) {
                            debugPrint("Driver phone number is not available.");
                            Get.snackbar("Error", "Driver's phone number is not available.");
                            return;
                          }
                          final uri = Uri.parse("tel:$phone");
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            debugPrint("Could not launch dialer for number: $phone");
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