import 'dart:async';
import 'package:get/get.dart';
import 'package:naderhosn/feature/auth/onboarding/view/onboarding.dart';

import '../../../core/services_class/shared_preferences_helper.dart';
import '../../bottom_nav_user/screen/bottom_nav_user.dart';
import '../screen/splash_screen.dart';

class SplashScreenController extends GetxController {
  void checkIsLogin() async {
    Timer(const Duration(seconds: 1), () async {
      final showOnboard = await SharedPreferencesHelper.getShowOnboard();
      final token = await SharedPreferencesHelper.getAccessToken();
      if (!showOnboard) {
        await SharedPreferencesHelper.setShowOnboard(true);
        Get.offAll(() => SplashScreen());
      } else if (token != null && token.isNotEmpty) {
        Get.to(() => BottomNavbarUser());
      } else {
        Get.offAll(OnboardingScreen());
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    checkIsLogin();
  }
}
