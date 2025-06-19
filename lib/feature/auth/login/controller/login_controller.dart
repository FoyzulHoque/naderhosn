import 'dart:convert';

//import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:naderhosn/core/network_caller/endpoints.dart';
import 'package:naderhosn/core/shared_preference/shared_preferences_helper.dart';

class LoginController extends GetxController {
  var isChecked = false.obs;
  var isPasswordHidden = true.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<void> loginUser() async {
    final url = Uri.parse('${Urls.baseUrl}/auth/login');

    try {
      //'String? fcmToken = await FirebaseMessaging.instance.getToken();
      //String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      //String? token = fcmToken ?? apnsToken;
      //String? token = fcmToken;
      // if (token != null) {
      //   debugPrint("Token: $token");
      // } else {
      //   debugPrint("Token is null");
      // }
      EasyLoading.show(status: 'Logging in...');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "emailOrPhone": emailController.text.trim(),
          "password": passwordController.text.trim(),
          // if (fcmToken != null) "fcmToken": fcmToken,
        }),
      );

      if (kDebugMode) {
        print("Response: ${response.body}");
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData["success"] == true) {
          if (responseData["data"] != null) {
            String token = responseData["data"]["token"] ?? "";

            if (token.isNotEmpty) {
              await SharedPreferencesHelper.saveToken(token);
              EasyLoading.showSuccess("Logged in successfully");
              //   Get.offAll(BottomNavbar());
            } else {
              EasyLoading.showError("Token is missing in response.");
            }
          } else {
            EasyLoading.showError("Invalid response: 'data' is null.");
          }
        } else {
          EasyLoading.showError(responseData["message"] ?? "Login failed.");
        }
      } else {
        EasyLoading.showError("An error occurred: ${response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("An error occurred: $e");
      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
