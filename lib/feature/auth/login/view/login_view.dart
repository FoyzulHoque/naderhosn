import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:naderhosn/core/global_widegts/custom_text_field.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/auth/forgot_pin/view/reset_pin_enter_seed_phrase.dart';
import 'package:naderhosn/feature/auth/login/controller/login_controller.dart';
import 'package:naderhosn/feature/auth/onboarding/controller/onboarding_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController controller = Get.put(LoginController());
  final OnboardingController onboardingController = Get.put(
    OnboardingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100,
            bottom: 50,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App Logo
              ClipRRect(
                borderRadius: BorderRadius.circular(4), // Add circular radius
                child: Image.asset(
                  "assets/icons/authicon.png", // Replace with actual logo asset
                  height: 56,
                ),
              ),
              const SizedBox(height: 20),

              // Welcome Text
              Text(
                "Welcome!",
                style: globalTextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Access your documents anytime, anywhere with AI-powered organization.",
                style: globalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff636F85),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              // Email/Phone Field using CustomTextField
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter Your PIN",
                  style: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Password Field using CustomTextField
              Obx(
                () => CustomTextField(
                  hintText: "Enter your password",
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      controller.isPasswordHidden.value =
                          !controller.isPasswordHidden.value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Forgot Password
              Row(
                children: [
                  // Native Checkbox with Obx
                  Obx(
                    () => Checkbox(
                      value: controller.isChecked.value,
                      onChanged: (value) {
                        controller.isChecked.value = value ?? false;
                      },
                      activeColor: Color(0xFF6056DD),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Remember me",
                    style: globalTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Forgot password action
                        Get.to(ResetPinEnterSeedPhrase());
                      },
                      child: Text(
                        "Forgot PIN",
                        style: globalTextStyle(
                          color: Color(0xffFF6F61),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // CustomButton2(
              //   title: 'Sign In',
              //   onPress: () {
              //     if (onboardingController.role.value == "SENDER") {
              //       Get.offAll(BottomNavbar());
              //     } else if (onboardingController.role.value == "COURIER") {
              //       Get.offAll(BottomNavbarCourier());
              //     } else {
              //       Fluttertoast.showToast(msg: "Invalid Role!");
              //     }

              //     //controller.loginUser();
              //   },
              // ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account?"),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign-up screen
                      //Get.to(CreateAccountSceen());
                    },
                    child: Text(
                      "Create Account",
                      style: globalTextStyle(
                        color: Color(0xff6056DD),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
