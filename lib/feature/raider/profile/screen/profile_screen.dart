import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/auth/login/view/login_view.dart';
import 'package:naderhosn/feature/raider/my_rides/screen/my_rides.dart';
import 'package:naderhosn/feature/raider/privacy_policy/screen/privacy_policy.dart';
import 'package:naderhosn/feature/raider/profile/widget/notification_widget.dart';
import 'package:naderhosn/feature/raider/profile/widget/profile_action_widgets.dart';
import 'package:naderhosn/feature/raider/profile/widget/profile_edit_screen.dart';

import '../../../../core/services_class/data_helper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Profile",
                style: globalTextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
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
                            image: const DecorationImage(
                              image: AssetImage("assets/images/profile.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "John Smith",
                          style: globalTextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF041023),
                          ),
                        ),
                        Text(
                          "johansmith@gmail.com",
                          // style: h74TextStyle(darkNavyBlue),
                        ),
                        Divider(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    Text(
                                      "My Rating",
                                      style: globalTextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF777F8B),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "4.8",
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
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    Text(
                                      "Total Distance ",
                                      style: globalTextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF777F8B),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "55.09KM",
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
                                    Icon(
                                      Icons.electric_bike,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    Text(
                                      "Total ride",
                                      style: globalTextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF777F8B),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "20",
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
                voidCallback: () {
                  Get.to(() => MyRides());

                  //  Get.snackbar("Hello", "");
                },
                iconData: (Icons.arrow_forward_ios),
                size: 18,
              ),
              const SizedBox(height: 21),
              ProfileActionWidgets(
                image: "assets/icons/terms.png",
                actionName: "Privacy policy",
                style: globalTextStyle(),
                voidCallback: () {
                  Get.to(() => PrivacyPolicy());
                },
                iconData: (Icons.arrow_forward_ios),
                size: 18,
              ),
              const SizedBox(height: 21),
              ProfileActionWidgets(
                image: "assets/icons/logout.png",
                actionName: "Log out",
                style: globalTextStyle(),
                voidCallback: () {
                  AuthController.dataClear();
                  Get.to(() => LoginView());
                },
                iconData: (Icons.arrow_forward_ios),
                size: 18,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
