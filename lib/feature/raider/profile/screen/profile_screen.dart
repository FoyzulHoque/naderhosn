import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/auth/login/view/login_view.dart';
import 'package:naderhosn/feature/raider/my_rides/screen/my_rides.dart';
import 'package:naderhosn/feature/raider/privacy_policy/screen/privacy_policy.dart';
import 'package:naderhosn/feature/raider/profile/widget/notification_widget.dart';
import 'package:naderhosn/feature/raider/profile/widget/profile_action_widgets.dart';
import 'package:naderhosn/feature/raider/profile/widget/profile_edit_screen.dart';

import '../controller/user_profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final UserProfileController controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    // Fetch profile data when screen opens
    controller.fetchUserProfile();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.userProfile.value == null) {
              return Center(
                child: Text(
                  controller.errorMessage.value.isEmpty
                      ? "No profile data found"
                      : controller.errorMessage.value,
                  style: globalTextStyle(fontSize: 16, color: Colors.red),
                ),
              );
            }

            final profile = controller.userProfile.value!;
            return Column(
              children: [
                Text(
                  "Profile",
                  style: globalTextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Profile Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => ProfileEditScreen());
                          },
                          child: Image.asset(
                            "assets/images/edit.png",
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 62,
                            width: 62,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: profile.profileImage != null &&
                                    profile.profileImage!.isNotEmpty
                                    ? NetworkImage(profile.profileImage!)
                                    : const AssetImage("assets/images/profile.png")
                                as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            profile.fullName ?? "Unknown User",
                            style: globalTextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF041023),
                            ),
                          ),
                          Text(profile.email ?? "No email"),
                          const Divider(),
                          const SizedBox(height: 16),

                          // Stats Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 20),
                                      Text(
                                        "My Rating",
                                        style: globalTextStyle(
                                          fontSize: 12,
                                          color: const Color(0xFF777F8B),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    profile.averageRating?.toString() ?? "0",
                                    style: globalTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.amber, size: 20),
                                      Text(
                                        "Total Distance",
                                        style: globalTextStyle(
                                          fontSize: 12,
                                          color: const Color(0xFF777F8B),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${profile.totalDistance ?? 0} KM",
                                    style: globalTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.electric_bike,
                                          color: Colors.amber, size: 20),
                                      Text(
                                        "Total Rides",
                                        style: globalTextStyle(
                                          fontSize: 12,
                                          color: const Color(0xFF777F8B),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    profile.totalRides?.toString() ?? "0",
                                    style: globalTextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 21),
                NotificationWidget(
                  tagId: "Notification",
                  image: "assets/icons/notification.png",
                  actionName: "Notification",
                  style: globalTextStyle(),
                  voidCallback: () => print("Switch toggled"),
                ),
                const SizedBox(height: 21),
                ProfileActionWidgets(
                  image: "assets/icons/car.png",
                  actionName: "My rides",
                  style: globalTextStyle(),
                  voidCallback: () => Get.to(() => MyRides()),
                  iconData: Icons.arrow_forward_ios,
                  size: 18,
                ),
                const SizedBox(height: 21),
                ProfileActionWidgets(
                  image: "assets/icons/terms.png",
                  actionName: "Privacy policy",
                  style: globalTextStyle(),
                  voidCallback: () => Get.to(() => PrivacyPolicy()),
                  iconData: Icons.arrow_forward_ios,
                  size: 18,
                ),
                const SizedBox(height: 21),
                ProfileActionWidgets(
                  image: "assets/icons/logout.png",
                  actionName: "Log out",
                  style: globalTextStyle(),
                  voidCallback: () => Get.to(() => LoginView()),
                  iconData: Icons.arrow_forward_ios,
                  size: 18,
                ),
                const SizedBox(height: 40),
              ],
            );
          }),
        ),
      ),
    );
  }
}
