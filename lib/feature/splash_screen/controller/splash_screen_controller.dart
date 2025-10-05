import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../core/services_class/data_helper.dart';
import '../../../core/services_class/shared_preferences_helper.dart';
import '../../auth/login/view/login_view.dart';
import '../../auth/onboarding/view/onboarding.dart';
import '../../bottom_nav_user/screen/bottom_nav_user.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLoginAndOnboarding();
  }

  Future<void> checkLoginAndOnboarding() async {
    // Show loading indicator for better UX
    EasyLoading.show(status: 'Loading...');

    try {
      // Wait for a minimum splash screen duration (2 seconds)
      await Future.delayed(const Duration(seconds: 2));

      // Check onboarding status
      final showOnboard = await SharedPreferencesHelper.getShowOnboard();
      if (!showOnboard) {
        // First-time user: show onboarding and mark it as shown
        await SharedPreferencesHelper.setShowOnboard(true);
        Get.offAll(() =>  OnboardingScreen());
        return;
      }

      // Check login status and token
      final isLogin = await AuthController.isUserLogin();
      final token = AuthController.accessToken;

      print("Token is: $token, isLogin: $isLogin");

      if (isLogin && token != null && token.isNotEmpty) {
        // User is logged in with a valid token: go to BottomNavbarUser
        Get.offAll(() => const BottomNavbarUser(), arguments: {
          'index': 0, // Default to HomeScreen
          'lat': null,
          'lng': null,
          'transportId': '', // Pass empty or actual ID if available
        });
      } else if (isLogin && (token == null || token.isEmpty)) {
        // User was logged in but token is invalid/expired: go to login
        EasyLoading.showToast("Your session has expired. Please log in again.");
        Get.offAll(() =>  LoginView());
      } else {
        // User is not logged in: go to onboarding
        Get.offAll(() =>  OnboardingScreen());
      }
    } catch (e) {
      print("Error in checkLoginAndOnboarding: $e");
      EasyLoading.showError("An error occurred. Please try again.");
      Get.offAll(() =>  OnboardingScreen());
    } finally {
      EasyLoading.dismiss();
    }
  }
}