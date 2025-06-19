import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:naderhosn/core/network_caller/endpoints.dart';
import 'package:naderhosn/feature/auth/phone_email_verification_code_password_change/view/phone_email_verification_code_password_change_screen.dart';

class ForgetPasswordController extends GetxController {
  var emailController = TextEditingController();
  Future<void> resetpassword() async {
    final url = Uri.parse('${Urls.baseUrl}/auth/forgot-password');

    try {
      EasyLoading.show(status: 'Loading...');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": emailController.text}),
      );

      if (kDebugMode) {
        print("//////////The response for sign up is: ${response.body}");
      }

      if (response.statusCode == 200) {
        EasyLoading.showSuccess("Success");
        final responseData = jsonDecode(response.body);
        if (responseData["success"] == true) {
          print(response.body);
          Get.offAll(
            () => OtpVerificationPasswordChangeView(),
            arguments: {'email': emailController.text},
          );
        }
      }
    } catch (e) {
      EasyLoading.showError("An error occurred: $e");
      if (kDebugMode) {
        print("///////////////An error occurred: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
