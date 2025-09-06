import 'package:flutter/material.dart';
import 'package:naderhosn/core/style/global_text_style.dart';

class RideHistoryTab extends StatelessWidget {
  final String imagePersion;
  final String imagelocation1;
  final String imagelocation2;
  final String textlocation1;
  final String textlocation2;
  final String textPersion;
  final String pricing;

  const RideHistoryTab({
    super.key,
    required this.imagePersion,
    required this.imagelocation1,
    required this.textPersion,
    required this.pricing,
    required this.imagelocation2,
    required this.textlocation1,
    required this.textlocation2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        height: 96,
        width: 339, // keep fixed width or make responsive
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Icon + Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset(imagePersion, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 1),
                        Text(
                          textPersion,
                          style: globalTextStyle(
                            color: const Color(0xFF000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset(imagelocation1, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          textlocation1,
                          style: globalTextStyle(
                            color: const Color(0xFF000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset(imagelocation2, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          textlocation2,
                          style: globalTextStyle(
                            color: const Color(0xFF000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Pricing
              Text(
                "\$$pricing",
                style: globalTextStyle(
                  color: const Color(0xFF4D5154),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
buildRow("assets/icons/user (2).png","Justin Westervelt"),
SizedBox(height: 2,),
buildRow("assets/icons/Frame.png","El-Baght Food Resmourants"),
SizedBox(height: 2,),
buildRow("assets/icons/location-08 (4).png","El-Baght Food Resmourants "),
*/
