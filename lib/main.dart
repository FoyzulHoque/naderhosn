import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/feature/splash_screen/screen/splash_screen.dart';
import 'package:naderhosn/feature/user/choose_taxi/screen/choose_taxi.dart';
import 'package:naderhosn/feature/user/confirm_pickup/screen/confirm_pickup.dart';
import 'package:naderhosn/feature/user/trip_request/screen/trip_request.dart';

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
      home: TripRequest(),
    );
  }
}
