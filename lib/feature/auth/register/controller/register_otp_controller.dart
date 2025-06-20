import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterOtpControllers extends GetxController {
  final TextEditingController otpController = TextEditingController();
  var otpError = false.obs;
  var otpErrorText = "".obs;
}
