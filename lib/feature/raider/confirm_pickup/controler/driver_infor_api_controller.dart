import 'package:get/get.dart';
import '../../../../core/network_caller/endpoints.dart';
import '../../../../core/network_caller/network_config.dart';
import '../model/rider_driver_info_model.dart';

class DriverInfoApiController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var rideData = Rx<RiderDriverInfoModel?>(null);

  Future<void> driverInfoApiMethod(String id) async {
    print("Calling driverInfoApiMethod with transportId: $id");

    try {
      if (id.isEmpty) {
        errorMessage.value = 'Transport ID is empty. Please provide a valid ID.';
        print("Error: Transport ID is empty");
        return;
      }

      isLoading.value = true;
      errorMessage.value = '';

      final url = Urls.carTransportsSingle(id);
      print("API Request URL: $url");

      NetworkResponse response = await NetworkCall.getRequest(url: url);
      print("API Response - Status: ${response.isSuccess}, Status Code: ${response.statusCode}");

      if (response.isSuccess && response.statusCode == 200) {
        final data = response.responseData?['data'];

        if (data != null) {
          Map<String, dynamic>? rideJson;

          // Defensive parsing: handle both Map and List
          if (data is Map<String, dynamic>) {
            rideJson = data;
          } else if (data is List && data.isNotEmpty && data[0] is Map<String, dynamic>) {
            rideJson = data[0];
          }

          if (rideJson != null) {
            rideData.value = RiderDriverInfoModel.fromJson(rideJson);

            final driver = rideData.value?.vehicle?.driver;
            if (driver == null) {
              errorMessage.value = 'Driver information is missing in the response.';
              print("Error: Driver info missing.");
            } else {
              print("Ride Data Loaded: ID=${rideData.value?.id}, Driver=${driver.fullName}");
            }
          } else {
            rideData.value = null;
            errorMessage.value = 'Invalid ride data format received from server.';
            print("⚠️ Invalid ride data format.");
          }
        } else {
          rideData.value = null;
          errorMessage.value = response.responseData?['message'] ?? 'No ride data available. Please try again.';
          print("⚠️ No ride data found: ${errorMessage.value}");
        }
      } else {
        errorMessage.value = response.errorMessage ?? 'Request failed with status code: ${response.statusCode}';
        rideData.value = null;
        print("API Error: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = 'Unexpected error: ${e.toString()}. Please try again.';
      rideData.value = null;
      print("Exception in driverInfoApiMethod: $e");
    } finally {
      isLoading.value = false;
      print("API call completed, isLoading: ${isLoading.value}");
    }
  }
}