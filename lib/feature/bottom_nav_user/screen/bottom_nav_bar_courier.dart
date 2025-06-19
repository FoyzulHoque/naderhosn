import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/const/nav_bar_images.dart';
import 'package:naderhosn/feature/bottom_nav_user/controller/bottom_nav_bar_courier_controller.dart';

class BottomNavbarCourier extends StatelessWidget {
  BottomNavbarCourier({super.key});

  final BottomNavUserController controller = Get.put(BottomNavUserController());

  final List<Widget> pages = [
    // CourierHome(),
    // EarningsScreen(),
    // CourierProfileScreen(),
  ];

  Future<bool> _onWillPop(BuildContext context) async {
    // Show the exit confirmation dialog
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you really want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Close the dialog and return false (do not exit)
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  // Close the dialog and return true (exit)
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false; // In case the dialog is closed without selecting an option, return false
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
                  activeImage: NavBarImages.earning,
                  passiveImage: NavBarImages.passEarning,
                ),
                // _buildNavItem(
                //   index: 2,
                //   activeImage: NavBarImages.actRec,
                //   passiveImage: NavBarImages.passRec,
                // ),
                _buildNavItem(
                  index: 2,
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