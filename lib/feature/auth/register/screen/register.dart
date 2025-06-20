import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/core/global_widegts/custom_container.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/auth/register/controller/register_controller.dart';
import 'package:naderhosn/feature/auth/register/screen/register_otp_verify.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Image.asset(
                  "assets/images/cross.png",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Text(
              "Enter your phone\nnumber",
              style: globalTextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            IntlPhoneField(
              onChanged: (phone) {
                controller.setPhoneNumber(phone.completeNumber);
              },
              onCountryChanged: (country) {
                controller.setCountryCode(country.dialCode);
              },
              decoration: InputDecoration(
                labelText: 'Enter phone number',
                border: OutlineInputBorder(),

                // focusedBorder: InputBorder.none,
                // enabledBorder: InputBorder.none,
              ),
              initialCountryCode: 'US',
            ),
            SizedBox(height: 20),
            CustomButton(
              title: "Continue",
              onPress: () {
                if (controller.phoneNumber.value.isEmpty) {
                  Get.snackbar("Phone no empty", "Please enter a phone number");
                } else {
                  Get.to(
                    () => RegisterOtpVerify(
                      userEmail: controller.phoneNumber.value,
                    ),
                  );
                }
              },
              backgroundColor: Color(0xFFFFDC71),
              borderColor: Colors.transparent,
              textStyle: globalTextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 1, width: 100, color: Colors.grey),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Or",
                    style: globalTextStyle(fontSize: 16, color: Colors.black45),
                  ),
                ),
                Container(height: 1, width: 100, color: Colors.grey),
              ],
            ),
            SizedBox(height: 15),
            CustomContainer(
              imageUrl: "assets/images/google.png",
              text: "Continue with Goggle",
              borderColor: Colors.grey,
              borderWidth: 0.7,
              align: TextAlign.center,
              onTap: () {},
            ),
            SizedBox(height: 15),
            CustomContainer(
              imageUrl: "assets/images/apple.png",
              text: "Continue with Goggle",
              borderColor: Colors.grey,
              borderWidth: 0.7,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
