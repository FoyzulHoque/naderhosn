/*
import 'package:get/get.dart';
import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/network_caller/network_config.dart';
import '../../../../core/network_path/natwork_path.dart';
import '../../../../core/services_class/shared_preferences_helper.dart';
import '../model/user_profile_model.dart';

class UserProfileController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = "".obs;
  var userProfile = Rxn<UserProfileModel>();

  /// Fetch Logged-in User Profile
  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    errorMessage.value = "";

    EasyLoading.show(status: "Fetching profile...");

    try {
      // Token
      final token = await SharedPreferencesHelper.getAccessToken();
      debugPrint("🔑 Token: $token");

      if (token == null || token.isEmpty) {
        errorMessage.value = "Access token not found. Please login.";
        EasyLoading.showError(errorMessage.value);
        debugPrint("❌ $errorMessage");
        return;
      }

      // Headers
      Map<String, String> headers = {
        "Authorization": token,
        "Content-Type": "application/json",
      };
      debugPrint("📌 Headers: $headers");

      // Call API
      NetworkResponse response = await NetworkCall.getRequest(
        url: NetworkPath.getMe,
        headers: headers,
      );

      debugPrint("🌍 Raw Response: ${response.responseData}");

      if (response.isSuccess) {
        final data = response.responseData?["data"];
        debugPrint("✅ Extracted data: $data");

        if (data != null && data is Map<String, dynamic>) {
          userProfile.value = UserProfileModel.fromJson(data);
          // debugPrint("👤 UserProfile Model: ${userProfile.value?.toJson()}");
        } else {
          userProfile.value = null;
          debugPrint("⚠️ Data is null or not a valid Map");
        }

        EasyLoading.showSuccess("Fetched successfully");
      } else {
        errorMessage.value =
            response.errorMessage ?? "Failed to load profile";
        EasyLoading.showError(errorMessage.value);
        debugPrint("❌ Error Message: ${errorMessage.value}");
      }
    } catch (e, stackTrace) {
      errorMessage.value = "Error: $e";
      EasyLoading.showError(errorMessage.value);
      debugPrint("💥 Exception: $e");
      debugPrint("📚 StackTrace: $stackTrace");
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
      debugPrint("🔄 Loading finished, isLoading = ${isLoading.value}");
    }
  }
}
*/
