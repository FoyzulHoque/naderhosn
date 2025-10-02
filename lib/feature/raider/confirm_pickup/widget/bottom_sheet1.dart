import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/controler/confirm_pickup_controller.dart';
import '../../payment/stripe controller/striper_controller.dart';
import '../controler/confirm_pick_up_api_controller.dart';

class ExpandedBottomSheet1 extends StatelessWidget {
  ExpandedBottomSheet1({super.key});

  final ConfirmPickupController uiController = Get.put(
    ConfirmPickupController(),
  );
  final ConfirmPickUpApiController apiController = Get.put(
    ConfirmPickUpApiController(),
  );
  final StripeService stripeService = Get.put(StripeService.instance);

  // Date in YYYY-MM-DD format (e.g., 2025-10-02)
  String getCurrentDate() {
    return DateTime.now().toIso8601String().substring(0, 10);
  }

  // Time in HH:MM format (e.g., 03:39)
  String getCurrentTime() {
    return DateTime.now().toString().substring(11, 16);
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed from ConfirmPickUpScreen
    final args = Get.arguments as Map<String, dynamic>? ?? {};

    // Data for displaying in the UI
    final String pickupAddress =
        args['pickupAddress'] as String? ?? 'No pickup address provided';

    // Data for the API call
    final String ridePlanId = args['ridePlanId']?.toString() ?? '';
    final String selectedDriverId = args['selectedDriverId']?.toString() ?? '';
    final String selectedVehicleId =
        args['selectedVehicleId']?.toString() ?? '';
    final String paymentMethodId = args['paymentMethodId']?.toString() ?? '';
    // Fix: Correctly handle totalAmount as double
    final double amount = (args['totalAmount'] is num)
        ? args['totalAmount'].toDouble()
        : (args['totalAmount'] is String && args['totalAmount'].isNotEmpty)
        ? double.tryParse(args['totalAmount']) ?? 0.0
        : 0.0;

    return DraggableScrollableSheet(
      initialChildSize: 0.26,
      minChildSize: 0.1,
      maxChildSize: 0.5,
      builder: (BuildContext scrollSheetContext, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Confirm Pick-up Location',
                      style: globalTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Divider(height: 1, thickness: 0.5),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Theme.of(scrollSheetContext).primaryColor,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          pickupAddress,
                          style: globalTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Amount: \$${amount.toStringAsFixed(2)}',
                  style: globalTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 25),
                Obx(() {
                  if (apiController.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return CustomButton(
                    backgroundColor: Colors.amberAccent,
                    title: 'Confirm Pick-up',
                    onPress: () async {
                      // Get current date and time
                      final String pickupDate = getCurrentDate();
                      final String pickupTime = getCurrentTime();

                      // Log for debugging
                      print(
                        "ExpandedBottomSheet1: 'Confirm Pick-up' button pressed.",
                      );
                      print(
                        "ExpandedBottomSheet1: Data -> ridePlanId: '$ridePlanId', "
                        "selectedDriverId: '$selectedDriverId', selectedVehicleId: '$selectedVehicleId', "
                        "paymentMethodId: '$paymentMethodId', amount: '$amount', "
                        "pickupTime: '$pickupTime', pickupDate: '$pickupDate'",
                      );

                      // Validate inputs
                      if (ridePlanId.isEmpty ||
                          selectedDriverId.isEmpty ||
                          selectedVehicleId.isEmpty) {
                        Get.snackbar(
                          'Input Error',
                          'Required ride details are missing (Ride ID, Driver ID, or Vehicle ID).',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.shade600,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      if (paymentMethodId.isEmpty) {
                        Get.snackbar(
                          'Payment Error',
                          'Please select a payment method.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.shade600,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      if (amount <= 0.0) {
                        Get.snackbar(
                          'Payment Error',
                          'Invalid payment amount.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.shade600,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      // Process payment with Stripe
                      final paymentSuccess = await stripeService.makePayment(
                        amount,
                        paymentMethodId, // Use paymentMethodId as cardId
                        ridePlanId, // Use ridePlanId as transportId
                      );

                      if (!paymentSuccess) {
                        Get.snackbar(
                          'Payment Failed',
                          'Could not process payment. Please try again.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.shade600,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      // Confirm ride only if payment succeeds
                      final isSuccess = await apiController
                          .confirmPickUpApiCallMethod(
                            ridePlanId,
                            selectedVehicleId,
                          );

                      if (isSuccess) {
                        Get.snackbar(
                          'Success',
                          'Ride confirmed successfully!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                        uiController.changeSheet(2);
                      } else {
                        Get.snackbar(
                          'Confirmation Failed',
                          apiController.errorMessage.value.isNotEmpty
                              ? apiController.errorMessage.value
                              : 'Could not confirm the ride. Please try again.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red.shade600,
                          colorText: Colors.white,
                        );
                      }
                    },
                  );
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
