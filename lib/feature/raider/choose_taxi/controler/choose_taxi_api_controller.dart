import 'package:get/get.dart';
import 'package:naderhosn/core/network_caller/network_config.dart';
import 'package:naderhosn/core/services_class/data_helper.dart';
import '../../../../core/network_caller/endpoints.dart';
import '../model/choose_taxi_model.dart';
import '../model/location_searching_model.dart';

class ChooseTaxiApiController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var rideDataList = <RidePlan2>[].obs;

  Future<void> chooseTaxiApiMethod() async {
    try {
      isLoading.value = true;
      NetworkResponse response =
      await NetworkCall.getRequest(url: Urls.carTransportsMyRidePlans);
      if (response.isSuccess) {
        final data = response.responseData!['data'];
        if (data is List) {
          rideDataList.value =
              data.map((e) => RidePlan2.fromJson(e)).toList();
          print("Ride Data List: ${rideDataList.length} plans loaded");
          for (var plan in rideDataList) {
            print("Ride Plan ID: ${plan.id}, Nearby Drivers: ${plan.nearbyDrivers?.length ?? 0}");
          }
        } else {
          rideDataList.clear();
          print("No ride plans found in response");
        }
        await AuthController.accessToken;
        errorMessage.value = '';
      } else {
        errorMessage.value = response.errorMessage ?? 'Unknown error';
        print("API Error: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print("Exception in chooseTaxiApiMethod: $e");
    } finally {
      isLoading.value = false;
    }
  }
}