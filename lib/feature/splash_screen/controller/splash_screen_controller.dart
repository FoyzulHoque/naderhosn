import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:naderhosn/core/shared_preference/shared_preferences_helper.dart';
import 'package:naderhosn/feature/auth/onboarding/view/onboarding.dart';
import 'package:naderhosn/feature/user/home/screen/home.dart';

class SplashScreenController extends GetxController {
  void checkIsLogin() async {
    Timer(const Duration(seconds: 3), () async {
      // Check if the token exists in shared preferences
      // String? token = await SharedPreferencesHelper.getAccessToken();
      // print("Token is : ${token}");
      // if (token != null && token.isNotEmpty) {
      //   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      //   String role = decodedToken["role"];

      //   if (role == "Sender") {
      //     Get.to(() => BottomNavbar());
      //   } else if (role == "Courier") {
      //     Get.to(() => BottomNavbarCourier());
      //   } else {
      //     EasyLoading.showSuccess("failed! ");
      //   }
      // } else {
      //   Get.offAll(SignInPage());
      // }
      Get.to(() => OnboardingScreen());
    });
  }

  @override
  void onInit() {
    super.onInit();
    checkIsLogin();
  }
}
