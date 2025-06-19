import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          children: [
            Image.asset(
              "assets/images/splash.png",
              width: screenSize.width,
              height: screenSize.height,
            ),

            //SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
