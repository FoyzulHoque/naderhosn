import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../../core/network_path/natwork_path.dart';
import '../../../../core/services_class/shared_preferences_helper.dart';
import '../model/profile_edit_model.dart';

class ProfileEditController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = "".obs;

  Future<void> updateProfile({
    required String fullName,
    required String phoneNumber,
    String? imagePath,
  }) async {
    isLoading.value = true;
    errorMessage.value = "";
    EasyLoading.show(status: "Updating profile...");

    try {
      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = "Access token not found. Please login.";
        EasyLoading.showError(errorMessage.value);
        return;
      }

      // Multipart request
      var request = http.MultipartRequest(
        "PATCH",
        Uri.parse(NetworkPath.updateProfile),
      );

      // Headers
      request.headers["Authorization"] = token;

      // Add JSON as string inside `data`
      Map<String, dynamic> data = {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
      };
      request.fields["data"] = jsonEncode(data);

      // Add file if exists
      if (imagePath != null && imagePath.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath("image", imagePath),
        );
      }

      // 🔹 Debug print request details
      print("📤 PATCH API CALL: /users/update-profile");
      print("➡️ Headers: ${request.headers}");
      print("➡️ Fields: ${request.fields}");
      print("➡️ File attached: ${imagePath ?? 'No file'}");

      // Send request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      // 🔹 Debug print response
      print("📥 Status Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final profile = UpdateProfileResponse.fromJson(jsonResponse);

        EasyLoading.showSuccess("Profile updated");
        print("✅ Updated Name: ${profile.data.fullName}");
        print("✅ Updated Phone: ${profile.data.phoneNumber}");
        print("✅ Updated Image: ${profile.data.profileImage}");
      } else {
        errorMessage.value = "Failed to update profile";
        EasyLoading.showError(errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
      EasyLoading.showError(errorMessage.value);
      print("❌ Exception: $e");
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

}
