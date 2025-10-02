import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/controler/confirm_pickup_controller.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/widget/bottom_sheet1.dart' hide globalTextStyle, ConfirmPickupController;
import 'package:naderhosn/feature/raider/confirm_pickup/widget/bottom_sheet2.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/widget/bottom_sheet3.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/widget/bottom_sheet4.dart';
import 'package:naderhosn/feature/raider/confirm_pickup/widget/bottom_sheet5.dart';

import '../../../../core/style/global_text_style.dart';
import '../../choose_taxi/controler/choose_taxi_controller.dart';

class ConfirmPickUpScreen extends StatelessWidget {
  final ConfirmPickupController controller = Get.put(ConfirmPickupController());
  final ChooseTaxiController chooseTaxiController = Get.put(ChooseTaxiController());


  ConfirmPickUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final String pickupAddress = args['pickup'] as String? ?? "No pickup address";
    final pickupLatArg = args['pickupLat'];
    final pickupLngArg = args['pickupLng'];
    final String dropOffAddress = args['dropOff'] as String? ?? "No dropOff address";
    final dropOffLatArg = args['dropOffLat'];
    final dropOffLngArg = args['dropOffLng'];
    final ridePlanId = args['ridePlanId'];
    final selectedDriverId = args['selectedDriverId'];
    final pickupTime = args['pickupTime'];
    final pickupDate = args['pickupDate'];
    final selectedVehicleId = args['selectedVehicleId'];

    final double pLat = double.tryParse(pickupLatArg?.toString() ?? '0.0') ?? 0.0;
    final double pLng = double.tryParse(pickupLngArg?.toString() ?? '0.0') ?? 0.0;
    final double dLat = double.tryParse(dropOffLatArg?.toString() ?? '0.0') ?? 0.0;
    final double dLng = double.tryParse(dropOffLngArg?.toString() ?? '0.0') ?? 0.0;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pLat != 0.0 || pLng != 0.0 || dLat != 0.0 || dLng != 0.0) {
        print("ChooseTaxiScreen: Calling loadAndDisplayRideData with arguments from previous screen.");
        chooseTaxiController.loadAndDisplayRideData(
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
            print("Rendering GoogleMap with ${chooseTaxiController.markers.length} markers");
            if (chooseTaxiController.isLoadingMap.value || (chooseTaxiController.isLoadingDirections.value && chooseTaxiController.markers.isEmpty)) {
              return const Center(child: CircularProgressIndicator());
            }

            if (chooseTaxiController.apiController.errorMessage.value.isNotEmpty && chooseTaxiController.markers.isEmpty) {
              return Center(child: Text("Error: ${chooseTaxiController.apiController.errorMessage.value}"));
            }

            if (chooseTaxiController.pickupPosition.value == null && chooseTaxiController.markers.isEmpty) {
              if (pLat != 0.0 || pLng != 0.0) {
                print("ChooseTaxiScreen: Displaying fallback map with arguments.");
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(pLat, pLng),
                    zoom: 15,
                  ),
                  onMapCreated: chooseTaxiController.onMapCreated,
                );
              }
              return const Center(child: Text("Map data could not be loaded or no ride found."));
            }

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: chooseTaxiController.pickupPosition.value ??
                    LatLng(pLat != 0.0 ? pLat : 23.749341, pLng != 0.0 ? pLng : 90.437213),
                zoom: 15,
              ),
              markers: controller.markers,
              polylines: controller.polyline.value.points.isNotEmpty
                  ? {controller.polyline.value}
                  : <Polyline>{},
              onMapCreated: chooseTaxiController.onMapCreated,
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
          Obx(() => buildBottomSheet(controller.currentBottomSheet.value)),
        ],
      ),
    );
  }

  Widget buildBottomSheet(int value) {
    switch (value) {
      case 1:
        return ExpandedBottomSheet1();
      case 2:
        return ExpandedBottomSheet2();
      case 3:
        return ExpandedBottomSheet3();
      case 4:
        return ExpandedBottomSheet4();
      case 5:
        return ExpandedBottomSheet5();
      default:
        return Container();
    }
  }
}
