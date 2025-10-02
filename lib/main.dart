import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:naderhosn/feature/splash_screen/screen/splash_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'feature/friends/controller/chat_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configEasyLoading();

  Get.put(ChatController());


import 'feature/raider/cost_calculate/screen/cost_calculate.dart';
import 'feature/raider/cost_calculate/screen/cost_calculate_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home:  SplashScreen(),
          builder: EasyLoading.init(), // ← important!
        );
      },
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
