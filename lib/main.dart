import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/feature/splash_screen/screen/splash_screen.dart';

import 'feature/raider/cost_calculate/screen/cost_calculate.dart';
import 'feature/raider/cost_calculate/screen/cost_calculate_location.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
