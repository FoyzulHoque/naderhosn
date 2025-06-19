import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:naderhosn/core/global_widegts/custom_text_field.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/auth/login/controller/login_controller.dart';

class CreatePin extends StatelessWidget {
  const CreatePin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff334155), size: 24),
          onPressed: () {
            // Handle back button action
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 50, left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Create new PIN 🔐",
                style: globalTextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Save the new password in a safe place, if you forget it then you have to do a forgot password again.",
              style: globalTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff636F85),
              ),
            ),
            SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "New PIN",
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
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Confirm PIN",
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
            Spacer(),

            // Use ternary operator to toggle between "Generate" and "Next"
            // CustomButton2(
            //   title: 'Reset PIN',
            //   onPress: () {
            //     // Handle confirm action
            //     Get.dialog(
            //       AlertDialog(
            //         backgroundColor: Colors.white,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         title: Column(
            //           children: [
            //             Align(
            //               alignment: Alignment.topRight,
            //               child: GestureDetector(
            //                 onTap: () {
            //                   Get.back(); // Close the dialog
            //                 },
            //                 child: Icon(
            //                   Icons.close,
            //                   color: Colors.black,
            //                   size: 24,
            //                 ),
            //               ),
            //             ),
            //             Image.asset("assets/icons/tick.png", height: 150),
            //             SizedBox(height: 10),
            //             Text(
            //               'Welcome Back!',
            //               style: globalTextStyle(
            //                 fontSize: 18,
            //                 fontWeight: FontWeight.w600,
            //                 color: Colors.black,
            //               ),
            //               textAlign: TextAlign.center,
            //             ),
            //             SizedBox(height: 10),
            //             Text(
            //               "You have successfully reset and created a new PIN.",
            //               textAlign: TextAlign.center,
            //               style: globalTextStyle(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w500,
            //                 color: Colors.black54,
            //               ),
            //             ),
            //             SizedBox(height: 10),
            //             CustomButton2(title: "GO TO HOME", onPress: () {}),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
