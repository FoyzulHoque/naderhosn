import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/feature/auth/user%20text%20editing%20controller/user_text_editing_controller.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/global_widegts/custom_button.dart';
import '../../../../core/style/global_text_style.dart';
import '../../add location/screen/screen.dart';
import '../../login/widget/backgroundimage.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final UserTextEditingController adminTextEditingController =
  Get.put(UserTextEditingController());

  // 👇 Add missing fields
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  final focusedBorderColor = Colors.blue;
  final fillColor = const Color.fromRGBO(243, 246, 249, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgroundImage(
        child: Stack(
          children: [
            const SizedBox(height: 40),
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(Icons.arrow_back_ios, size: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    SizedBox(
                      height: 88,
                      width: 277,
                      child: Text(
                        "Verification",
                        style: globalTextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          lineHeight: 1.5,
                          color: const Color(0xFF041020),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Hay, We had send you code number by",
                            style: globalTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              lineHeight: 1.5,
                              color: const Color(0xFF454F60),
                            )),
                        const SizedBox(height: 20),
                        Text(
                            "+54544645454",
                            style: globalTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              lineHeight: 1.5,
                              color: const Color(0xFF454F60),
                            )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: adminTextEditingController.otp,
                        focusNode: focusNode,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) =>
                        const SizedBox(width: 8),
                        validator: (value) {
                          return value == '2222'
                              ? null
                              : 'Pin is incorrect';
                        },
                        hapticFeedbackType:
                        HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border:
                            Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(19),
                            border:
                            Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border:
                            Border.all(color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                        title: "Resend OTP",
                        onPress: (){
                          /* focusNode.unfocus();
                          if (formKey.currentState!.validate()) {
                            Get.snackbar(
                              "Success",
                              "OTP is correct!",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }*/
                        }
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      title: "Continue",
                      onPress: _otpApiHitButton,
                      backgroundColor: Color(0xFFFFDC71),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _otpApiHitButton() {
    focusNode.unfocus();
    if(adminTextEditingController.otp.text=="1234"){
      Get.to(AddLocationScreen());
    }
  }
}
