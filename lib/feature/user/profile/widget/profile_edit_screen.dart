import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/global_widegts/custom_button.dart';
import 'package:naderhosn/feature/user/profile/widget/profile_image.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Profile'),
        // titleTextStyle: h55TextStyle(darkNavyBlue),
        centerTitle: true,
        //  backgroundColor: lightPinkishWhite,
        elevation: 0,
      ),
      // backgroundColor: lightPinkishWhite,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            ProfileImage(),
            const SizedBox(height: 24),

            // Name Field
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Name",
                hintStyle: const TextStyle(
                  // Ensures visibility
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Phone Number Field
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Phone Number",
                hintStyle: const TextStyle(
                  // Ensures visibility
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 40),

            Spacer(),

            CustomButton(
              title: "Save",
              backgroundColor: Color(0xFfFFDC71),
              borderColor: Colors.transparent,
              onPress: () {},
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
