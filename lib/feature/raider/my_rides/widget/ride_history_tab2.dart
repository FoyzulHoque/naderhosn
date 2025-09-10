import 'package:flutter/material.dart';
import 'package:naderhosn/feature/raider/my_rides/widget/ride_history_tap.dart';
// Make sure to add this import for Google Maps
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideHistoryTab2 extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Widget widget;
  final Widget? googleMapChild;

  const RideHistoryTab2({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.widget,
    this.googleMapChild,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Main Ride Card
            Container(
              width: 339,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF0F0F0)),
              ),
              child: Column(
                children: [
                  /// Map + Button Overlay
                  SizedBox(
                    height: 144,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        /// Google Map (only if provided)
                        if (googleMapChild != null) googleMapChild!,
                        /// Button Positioned on Map
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              buttonText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Ride Info Section
                  widget,
                ],
              ),
            ),

            /*const SizedBox(height: 12),

            /// Extra Images Below
            Image.asset("assets/images/img2.png"),
            const SizedBox(height: 12),
            Image.asset("assets/images/img2.png"),*/
          ],
        ),
      ),
    );
  }
}
