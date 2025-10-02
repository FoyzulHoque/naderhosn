import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/fare_model.dart';

class FareController extends GetxController {
  var isLoading = false.obs;
  var fare = Rxn<FareModel>();

  /// =======================
  /// Fetch Fare Data
  /// =======================
  Future<void> fetchFareData(String token) async {
    try {
      isLoading.value = true;
      print("🔄 Fetching fare data...");

      final response = await http.get(
        Uri.parse("https://brother-taxi.onrender.com/api/v1/estimateFares/getMyEstimatelist"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,  // ✅ raw token use
        },
      );
      print("token:  $token");
      print("📡 API Status: ${response.statusCode}");
      print("📥 API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is Map<String, dynamic> && data.containsKey("data")) {
          final fareData = data["data"];
          fare.value = FareModel.fromJson(fareData);
          print("✅ Fare loaded: ${fare.value}");
        } else {
          print("❌ Invalid data format received: $data");
          Get.snackbar("Error", "Invalid data format received");
        }
      } else {
        print("❌ Failed to load fare data: ${response.statusCode}");
        Get.snackbar("Error", "Failed to load fare data: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
      print("✅ Fetch completed");
    }
  }

  /// =======================
  /// Send Pickup & DropOff Location
  /// =======================
  Future<void> sendPickupDropLocation({
    required String pickup,
    required String dropOff,
    required double pickupLat,
    required double pickupLng,
    required double dropLat,
    required double dropLng,
  }) async {
    try {
      print("🔄 Sending pickup/drop-off location...");

      final body = jsonEncode({
        "pickup": pickup,
        "dropOff": dropOff,
        "pickupLocation": {"lat": pickupLat, "lng": pickupLng},
        "dropOffLocation": {"lat": dropLat, "lng": dropLng},
      });

      final response = await http.post(
        Uri.parse("https://brother-taxi.onrender.com/api/v1/estimateFares/calculate-fare"), // তোমার API endpoint
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("📡 API Status: ${response.statusCode}");
      print("📥 API Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Pickup/Drop-off location sent successfully");
        // যদি response-এ fare আসে, update করতে পারো:
        final data = json.decode(response.body);
        if (data["success"] == true && data.containsKey("data")) {
          fare.value = FareModel.fromJson(data["data"]);
          print("✅ Fare updated from location API: ${fare.value}");
        }
      } else {
        print("❌ Failed to send pickup/drop-off. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("⚠️ Exception sending pickup/drop-off: $e");
    }
  }

  /// =======================
  /// Calculate Distance
  /// =======================
  double calculateDistance(
      double pickupLat,
      double pickupLng,
      double dropLat,
      double dropLng,
      ) {
    double distanceInMeters = Geolocator.distanceBetween(
      pickupLat,
      pickupLng,
      dropLat,
      dropLng,
    );
    double distanceKm = distanceInMeters / 1000; // km
    print("📏 Distance: $distanceKm km");
    return distanceKm;
  }

  /// =======================
  /// Calculate Total Fare
  /// =======================
  double calculateTotalFare(
      double distanceKm, {
        int durationMinutes = 0,
        int waitingMinutes = 0,
      }) {
    if (fare.value == null) {
      print("⚠️ Fare data is null, returning 0");
      return 0.0;
    }

    final f = fare.value!;
    double distanceFare = f.costPerKm * distanceKm;
    double timeFare = f.costPerMin * durationMinutes;
    double waitingFare = f.waitingPerMin * waitingMinutes;

    double total = f.baseFare + distanceFare + timeFare + waitingFare;

    if (total < f.minimumFare) {
      total = f.minimumFare;
    }

    print("""
    🔎 Fare Calculation:
    Base Fare: ${f.baseFare}
    Distance Fare: $distanceFare
    Time Fare: $timeFare
    Waiting Fare: $waitingFare
    👉 Total Fare: $total
    """);

    return total;
  }
}
