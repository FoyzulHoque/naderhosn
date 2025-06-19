import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/auth/phone_email_verification_code_password_change/controller/phone_email_verification_code_password_change_controller.dart';

class OtpVerificationPasswordChangeView extends StatelessWidget {
  OtpVerificationPasswordChangeView({super.key});
  final OtpVerificationPasswordChangeController controller = Get.put(
    OtpVerificationPasswordChangeController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 100, bottom: 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //CustomBackButton(),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width *
                      0.03, // Responsive spacing
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Verification code",
                        style: globalTextStyle(
                          color: Colors.black,
                          fontSize:
                              MediaQuery.of(context).size.width *
                              0.045, // Responsive font size
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ), // Add spacing between the text blocks
                      Text(
                        "Please check email. We have sent the code verification to your number ",
                        softWrap: true,
                        style: globalTextStyle(
                          color: Colors.black,
                          fontSize:
                              MediaQuery.of(context).size.width *
                              0.035, // Responsive font size
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 50),
            OtpTextField(
              numberOfFields: 4,

              textStyle: globalTextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              borderRadius: BorderRadius.circular(12),
              onSubmit: (otp) {
                controller.setOtp(otp);
                if (kDebugMode) {
                  print("Entered OTP: $otp");
                }
              },
              fieldWidth: 60,
              borderWidth: 2,
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              showFieldAsBox: true,
            ),
            SizedBox(height: 20),
            // Timer
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Resend code in ",
                    style: globalTextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    formatTime(controller.startTime.value),
                    style: globalTextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              return controller.startTime.value == 0
                  ? InkWell(
                      onTap: controller.resend,
                      child: Text(
                        "Resend",
                        style: globalTextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SizedBox.shrink();
            }),
            const Spacer(),
            CustomButton(
              title: 'Verify',
              onPress: () {
                controller.verifyOtp();
              },
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(int time) {
    int minutes = time ~/ 60;
    int seconds = time % 60;
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }
}
