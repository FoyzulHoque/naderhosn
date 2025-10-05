import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/const/nav_bar_images.dart';
import 'package:naderhosn/feature/bottom_nav_user/controller/bottom_nav_user_controller.dart';
import 'package:naderhosn/feature/raider/cost_calculate/screen/cost_calculate.dart';
import 'package:naderhosn/feature/raider/home/screen/home.dart';
import 'package:naderhosn/feature/raider/profile/screen/profile_screen.dart';
import '../../friends/screen/chat_screen.dart';

class BottomNavbarUser extends StatelessWidget {
  const BottomNavbarUser({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final BottomNavUserController controller = Get.put(BottomNavUserController());

    // Safely retrieve arguments with null checks
    final args = Get.arguments as Map<String, dynamic>?;
    final double? lat = args != null ? (args['lat'] as num?)?.toDouble() : null;
    final double? lng = args != null ? (args['lng'] as num?)?.toDouble() : null;
    final int startIndex = args != null ? (args['index'] as int? ?? 0) : 0;
    final String carTransportId = args != null ? (args['transportId']?.toString() ?? '') : '';

    // Validate startIndex to prevent out-of-bounds errors
    if (startIndex < 0 || startIndex >= 4) {
      controller.changeIndex(0); // Default to Home if invalid
    } else {
      controller.changeIndex(startIndex);
    }

    // Define pages with dynamic arguments
    final List<Widget> pages = [
      HomeScreen(lat: lat, lng: lng),
       CostCalculate(),
      ChatScreen(carTransportId: carTransportId),
       ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async => await _onWillPop(context),
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

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you really want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  Widget _buildNavItem({
    required int index,
    required String activeImage,
    required String passiveImage,
  }) {
    return GestureDetector(
      onTap: () => Get.find<BottomNavUserController>().changeIndex(index),
      child: Obx(() {
        final controller = Get.find<BottomNavUserController>();
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