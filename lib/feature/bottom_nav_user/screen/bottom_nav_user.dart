import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/const/nav_bar_images.dart';
import 'package:naderhosn/feature/bottom_nav_user/controller/bottom_nav_user_controller.dart';
import 'package:naderhosn/feature/raider/cost_calculate/screen/cost_calculate.dart';
import 'package:naderhosn/feature/raider/home/screen/home.dart';
import 'package:naderhosn/feature/raider/profile/screen/profile_screen.dart';

import '../../friends/screen/chat_screen.dart';

class BottomNavbarUser extends StatelessWidget {
  BottomNavbarUser({super.key});

  final BottomNavUserController controller = Get.put(BottomNavUserController());

  final String carTransportId = "68dac36a9d6556e4d3aa05eb";

  late final List<Widget> pages = [
    HomeScreen(),
    CostCalculate(),
    ChatScreen(carTransportId: carTransportId),
    ProfileScreen(),
  ];

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you really want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => pages[controller.currentIndex.value]),

        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  index: 0,
                  activeImage: NavBarImages.acthome,
                  passiveImage: NavBarImages.passhome,
                ),
                _buildNavItem(
                  index: 1,
                  activeImage: NavBarImages.actCalculate,
                  passiveImage: NavBarImages.passCalculate,
                ),
                _buildNavItem(
                  index: 2,
                  activeImage: NavBarImages.actChat,
                  passiveImage: NavBarImages.passChat,
                ),
                _buildNavItem(
                  index: 3,
                  activeImage: NavBarImages.actprofile,
                  passiveImage: NavBarImages.passprofile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String activeImage,
    required String passiveImage,
  }) {
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Obx(() {
        final isSelected = controller.currentIndex.value == index;
        return Image.asset(
          isSelected ? activeImage : passiveImage,
          height: 45,
          fit: BoxFit.contain,
        );
      }),
    );
  }
}



// children: [
//                 _buildTile(
//                   Icons.person_outline,
//                   "Personal Information",
//                   onTap: () => Get.to(() => PersonalInformation()),
//                 ),
//                 _buildTile(
//                   Icons.directions_car,
//                   "Vehicle Information",
//                   onTap: () => Get.to(() => VehicleInformation()),
//                 ),
//                 _buildTile(
//                   Icons.attach_money,
//                   "Set Your Price",
//                   onTap: () => Get.to(() => Pricing()),
//                 ),
//                 _buildTile(
//                   Icons.lock_outline,
//                   "Password",
//                   onTap: () => Get.to(() => ChangePassword()),
//                 ),
//                 _buildSwitchTile(Icons.notifications_none, "Notification"),

//                 _buildTile(
//                   Icons.description_outlined,
//                   "Terms & Privacy",
//                   onTap: () => Get.to(() => TermsPrivacy()),
//                 ),
//                 _buildTile(
//                   Icons.help_outline,
//                   "Help & Support",
//                   onTap: () => Get.to(() => HelpAndSupport()),
//                 ),
//                 _buildTile(
//                   Icons.feedback_outlined,
//                   "Share Feedback",
//                   onTap: () => Get.to(() => ShareFeedback()),
//                 ),
//                 _buildTile(
//                   Icons.delete_outline,
//                   "Delete Account",
//                   onTap: () => Get.dialog(CancelDeliveryDialog()),
//                 ),
//                 _buildTile(
//                   Icons.logout,
//                   "Sign Out",
//                   onTap: () async {
//                     try {
//                       await SharedPreferencesHelper.clearAllData();
//                       Get.to(() => SignInPage());
//                     } catch (e) {
//                       print(e);
//                     }
//                   },
//                 ),
//               ],