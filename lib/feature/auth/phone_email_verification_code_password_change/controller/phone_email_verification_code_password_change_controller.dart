import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/network_caller/endpoints.dart';
import 'package:naderhosn/feature/auth/set_password/view/set_password_screen.dart';

class OtpVerificationPasswordChangeController extends GetxController {
  RxInt startTime = 180.obs; // 3 minutes timer
  Timer? _timer;

  RxString otp = ''.obs; // Store OTP value
  String email = ''; // Email to be passed as argument

  @override
  void onInit() {
    super.onInit();
    // Fetch email from arguments
    email = Get.arguments?['email'] ?? '';
    startTimer();
  }

  // Start the timer
  void startTimer() {
    if (kDebugMode) {
      print("Starting timer for 3 minutes...");
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (startTime.value > 0) {
        startTime.value--;
        if (kDebugMode) {
          print("Timer countdown: ${startTime.value} seconds remaining");
        }
      } else {
        if (kDebugMode) {
          print("Timer finished.");
        }
        _timer?.cancel();
      }
    });
  }

  // Set OTP value
  void setOtp(String otpValue) {
    otp.value = otpValue;
    if (kDebugMode) {
      print("OTP entered: $otpValue");
    }
  }

  // // Resend action
  Future<void> resend() async {
    if (kDebugMode) {
      print("Resend OTP initiated for email: $email");
    }
    try {
      EasyLoading.show(status: 'Resending OTP...');
      startTime.value = 180; // Reset timer to 3 minutes
      startTimer();

      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/auth/resend-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (kDebugMode) {
        print("Resend OTP API Response: ${response.body}");
      }

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (kDebugMode) {
          print("Resend OTP Success: $data");
        }
        if (data['success'] == true) {
          /// EasyLoading.showSuccess(data['message']);
        } else {
          //EasyLoading.showError(data['message'] ?? "Resend failed");
        }
      } else {
        if (kDebugMode) {
          print("Resend OTP Failed with status code: ${response.statusCode}");
        }
        //EasyLoading.showError("Error: ${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception in resend OTP: $e");
      }
      EasyLoading.showError("An error occurred. Please try again.");
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Verify OTP
  Future<void> verifyOtp() async {
    if (kDebugMode) {
      print("Verify OTP initiated with OTP: ${otp.value} and email: $email");
    }

    if (otp.value.isEmpty || otp.value.length != 4) {
      if (kDebugMode) {
        print("Invalid OTP: ${otp.value}");
      }
      EasyLoading.showError("Please enter a valid 4-digit OTP");
      return;
    }

    try {
      EasyLoading.show(status: 'Verifying...');
      final response = await http.post(
        Uri.parse("${Urls.baseUrl}/auth/verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": int.parse(otp.value)}),
      );

      if (kDebugMode) {
        print("Verify OTP API Response: ${response.body}");
      }

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (kDebugMode) {
          print("Verify OTP Success: $data");
        }
        if (data['success'] == true) {
          EasyLoading.showSuccess("OTP verified successfully");
          Get.offAll(() => SetPasswordScreen(), arguments: {"email": email});
        } else {
          if (kDebugMode) {
            print("Invalid OTP: ${data['message']}");
          }
          //EasyLoading.showError(data['message'] ?? "Invalid OTP");
        }
      } else {
        if (kDebugMode) {
          print("Verify OTP Failed with status code: ${response.statusCode}");
        }
        //EasyLoading.showError("Error: ${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception in verify OTP: $e");
      }
      //EasyLoading.showError("An error occurred. Please try again.");
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void onClose() {
    if (kDebugMode) {
      print("EmailVerificationController is being closed. Timer cancelled.");
    }
    _timer?.cancel();
    super.onClose();
  }
}
