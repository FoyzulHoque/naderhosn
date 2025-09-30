import 'package:get/get.dart';
import 'package:naderhosn/core/network_caller/network_config.dart';
import 'package:naderhosn/core/services_class/data_helper.dart';
import '../../../../core/network_caller/endpoints.dart';
import '../model/choose_taxi_model.dart';
import '../model/location_searching_model.dart';

class ChooseTaxiApiController extends GetxController {
  // Observables
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
        } else {
          rideDataList.clear();
        }
        await AuthController.accessToken;
        errorMessage.value = '';
      } else {
        errorMessage.value = response.errorMessage ?? 'Unknown error';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}/*
import 'package:get/get.dart';
import 'package:naderhosn/core/network_caller/network_config.dart';
import 'package:naderhosn/core/services_class/data_helper.dart';
import '../../../../core/network_caller/endpoints.dart';
import '../model/choose_taxi_model.dart';
import '../model/location_searching_model.dart';

class ChooseTaxiApiController extends GetxController {
  // Observables
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var rideDataList = <RidePlan2>[].obs;

  Future<void> chooseTaxiApiMethod({
    required String pickup,
    required String dropOff,
    required double pickupLat,
    required double pickupLng,
    required double dropOffLat,
    required double dropOffLng,
    String serviceType = 'MiniRide',
  }) async {
    try {
      isLoading.value = true;
      // Construct full URL with query parameters
      String baseUrl = '${Urls.carTransportsMyRidePlans}';
      String queryParams = '?pickup=$pickup'
          '&dropOff=$dropOff'
          '&pickupLat=$pickupLat'
          '&pickupLng=$pickupLng'
          '&dropOffLat=$dropOffLat'
          '&dropOffLng=$dropOffLng'
          '&serviceType=$serviceType';
      String fullUrl = baseUrl + queryParams;
      print("API GET Request URL: $fullUrl"); // Debug log
      NetworkResponse response = await NetworkCall.getRequest(
        url: fullUrl,
      );
      if (response.isSuccess) {
        final responseData = response.responseData as Map<String, dynamic>? ?? {};
        final data = responseData['data'] as Map<String, dynamic>? ?? {};
        final ridePlanJson = data['ridePlan'] as Map<String, dynamic>? ?? {};
        final nearbyDriversJson = data['nearbyDrivers'] as List<dynamic>? ?? [];
        final ridePlan = RidePlan2.fromJson(ridePlanJson);
        final carTransports = nearbyDriversJson.map<CarTransport>((json) {
          return CarTransport.fromJson({
            'id': json['id'],
            'driverLat': json['lat'],
            'driverLng': json['lng'],
            'vehicleId': json['vehicleId'],
            'serviceType': json['vehicleName'],
            'distance': json['distance'],
            'totalAmount': ridePlan.estimatedFare,
          });
        }).toList();
        final updatedRidePlan = RidePlan2(
          id: ridePlan.id,
          userId: ridePlan.userId,
          pickup: ridePlan.pickup,
          dropOff: ridePlan.dropOff,
          pickupLat: ridePlan.pickupLat,
          pickupLng: ridePlan.pickupLng,
          dropOffLat: ridePlan.dropOffLat,
          dropOffLng: ridePlan.dropOffLng,
          rideTime: ridePlan.rideTime,
          waitingTime: ridePlan.waitingTime,
          distance: ridePlan.distance,
          estimatedFare: ridePlan.estimatedFare,
          serviceType: ridePlan.serviceType,
          createdAt: ridePlan.createdAt,
          updatedAt: ridePlan.updatedAt,
          carTransport: carTransports,
        );
        rideDataList.value = [updatedRidePlan];
        errorMessage.value = '';
      } else {
        errorMessage.value = response.errorMessage ?? 'Unknown error';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}*/