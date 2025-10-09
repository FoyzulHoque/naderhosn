/*
import 'package:get/get.dart';
import 'package:naderhosn/core/network_caller/network_config.dart';
import 'package:naderhosn/core/services_class/data_helper.dart';
import '../../../../core/network_caller/endpoints.dart';
import '../model/choose_taxi_model.dart';

class ChooseTaxiApiController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final rideDataList = <RidePlan2>[].obs;

  /// Fetches ride plans assigned to the logged-in user.
  Future<void> chooseTaxiApiMethod() async {
    if (isLoading.value) return; // prevent duplicate API calls
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await NetworkCall.getRequest(
        url: Urls.carTransportsMyRidePlans,
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData!['data'];

        if (data is List) {
          final parsedList =
          data.map((e) => RidePlan2.fromJson(e)).toList(growable: false);
          //AuthController.saveUserId(rideDataList[0].carTransport[].id);

          // Use .assignAll instead of .value = to avoid unnecessary rebuild timing
          rideDataList.assignAll(parsedList);

          print("✅ ${rideDataList.length} ride plans loaded successfully");
          for (var plan in rideDataList) {
            print(
                "🛻 RidePlan ID: ${plan.id}, Nearby Drivers: ${plan.nearbyDrivers?.length ?? 0}");
          }
        } else {
          rideDataList.clear();
          print("⚠️ No ride plans found in response data");
        }
      } else {
        errorMessage.value = response.errorMessage ?? 'Unknown error occurred';
        print("❌ API Error: ${errorMessage.value}");
      }
    } catch (e, st) {
      errorMessage.value = 'Exception: $e';
      print("🔥 Exception in chooseTaxiApiMethod: $e\n$st");
    } finally {
      isLoading.value = false;
    }
  }
}
*/
import 'package:get/get.dart';
import 'package:naderhosn/core/network_caller/network_config.dart';
import 'package:naderhosn/core/services_class/data_helper.dart';
import '../../../../core/network_caller/endpoints.dart';
import '../model/choose_taxi_model.dart';

class ChooseTaxiApiController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final rideDataList = <RidePlan2>[].obs;

  /// Fetches ride plans assigned to the logged-in user.
  Future<void> chooseTaxiApiMethod() async {
    if (isLoading.value) return; // Prevent duplicate calls

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await NetworkCall.getRequest(
        url: Urls.carTransportsMyRidePlans,
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData!['data'];

        if (data is List) {
          final parsedList =
          data.map((e) => RidePlan2.fromJson(e)).toList(growable: false);

          // Assign the parsed list to rideDataList
          rideDataList.assignAll(parsedList);

          print("✅ ${rideDataList.length} ride plans loaded successfully");

          // Save the first transportId if available
          if (rideDataList.isNotEmpty &&
              rideDataList[0].carTransport != null &&
              rideDataList[0].carTransport!.isNotEmpty) {
            final firstTransportId = rideDataList[0].carTransport![0].id;
            if (firstTransportId != null && firstTransportId.isNotEmpty) {
              AuthController.saveUserId(firstTransportId);
              print("-------------📦 Saved transportId: $firstTransportId");
            }
          }

          for (var plan in rideDataList) {
            print(
                "🛻 RidePlan ID: ${plan.id}, Nearby Drivers: ${plan.nearbyDrivers?.length ?? 0}");
          }
        } else {
          rideDataList.clear();
          print("⚠️ No ride plans found in response data");
        }
      } else {
        errorMessage.value = response.errorMessage ?? 'Unknown error occurred';
        print("❌ API Error: ${errorMessage.value}");
      }
    } catch (e, st) {
      errorMessage.value = 'Exception: $e';
      print("🔥 Exception in chooseTaxiApiMethod: $e\n$st");
    } finally {
      isLoading.value = false;
    }
  }
}
