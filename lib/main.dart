import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:naderhosn/feature/splash_screen/screen/splash_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'feature/friends/controller/chat_controller.dart';
import 'feature/friends/service/chat_service.dart';
import 'feature/raider/end_ride/controler/end_ride_controller.dart';
import 'feature/raider/pickup_accept/controler/pickup_accept_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLoading
  configEasyLoading();

  // Initialize GetX controllers
  Get.put(ChatController());
  Get.put(WebSocketService());
  // Initialize ScreenUtil
  await ScreenUtil.ensureScreenSize();

  runApp(const MyApp());
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.grey
    ..textColor = Colors.white
    ..indicatorColor = Colors.white
    ..maskColor = Colors.green
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Matches your design reference
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'NaderHosn',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home:  SplashScreen(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}