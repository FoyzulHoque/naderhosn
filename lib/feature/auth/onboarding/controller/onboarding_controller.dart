import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/feature/auth/login/view/login_view.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  void onNextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Get.to(() => LoginView());
    }
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }
}
