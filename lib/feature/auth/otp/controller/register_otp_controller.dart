import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/network_caller/network_config.dart';
import 'package:naderhosn/core/network_path/natwork_path.dart';
import 'package:naderhosn/core/services_class/data_helper.dart';
import 'package:naderhosn/feature/auth/login/model/rider_model.dart';
import 'package:naderhosn/feature/auth/user%20text%20editing%20controller/user_text_editing_controller.dart';

class RegisterOtpControllers extends GetxController {
  final TextEditingController otpController = TextEditingController();
  var otpError = false.obs;
  var otpErrorText = "".obs;

  final UserTextEditingController userTextEditingController =
  Get.put(UserTextEditingController());

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  RiderModel? riderModel;

  /// OTP API Call
  Future<bool> otpApiRiderMethod() async {
    bool isSuccess = false;
    debugPrint("🚀 otpApiRiderMethod started.");

    try {
      Map<String, dynamic> mapBody = {
        "phoneNumber": userTextEditingController.countryCodeAndPhone.trim(),
        "otp": int.parse(userTextEditingController.otp.text.trim()),
        "role": "RIDER",
      };

      debugPrint("📤 Sending OTP Verify Body => $mapBody");

      NetworkResponse response = await NetworkCall.postRequest(
        url: NetworkPath.authVerifyLogin,
        body: mapBody,
      );

      debugPrint("📥 API Response Status Code: ${response.statusCode}");
      debugPrint("📥 API Response Data: ${response.responseData}");

      if (response.isSuccess) {

        String token=response.responseData!['data']["token"];
        RiderModel riderModel=RiderModel.fromJson(response.responseData!["data"]);
        await AuthController.setUserData(token,riderModel);
        isSuccess=true;
        _errorMessage=null;
        update();
      }
    } catch (e) {
      _errorMessage = "Exception: $e";
      debugPrint("❌ OTP Verify Exception: $e");
      isSuccess =false;
      update;
    }

    debugPrint("🏁 Final success status: $isSuccess");
    return isSuccess;
  }
}