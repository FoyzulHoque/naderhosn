import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/feature/splash_screen/screen/splash_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'feature/raider/friends/controller/chat_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configEasyLoading();

  Get.put(ChatController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // <-- Set your design size (width x height)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: child,
          builder: (context, widget) {
            // Combine EasyLoading with ScreenUtil
            widget = EasyLoading.init()(context, widget);
            return widget;
          },
        );
      },
      child:  SplashScreen(), // <-- Your initial screen
    );
  }
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
