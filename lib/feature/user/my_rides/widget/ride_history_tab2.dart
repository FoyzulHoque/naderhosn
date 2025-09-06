import 'package:flutter/material.dart';
import 'package:naderhosn/feature/user/my_rides/widget/ride_history_tap.dart';

class RideHistoryTab2 extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Widget widget;

  const RideHistoryTab2({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.widget,
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
                  Container(
                    height: 144,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      color: Colors.grey[200], // placeholder for map bg
                    ),
                    child: Stack(
                      children: [
                        // Google Map Placeholder
                        // ClipRRect(
                        //   borderRadius: const BorderRadius.vertical(
                        //     top: Radius.circular(16),
                        //   ),
                        //   child: GoogleMap(
                        //     initialCameraPosition: CameraPosition(
                        //       target: LatLng(23.8103, 90.4125), // Dhaka as default
                        //       zoom: 14,
                        //     ),
                        //   ),
                        // ),

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

            const SizedBox(height: 12),

            /// Extra Images Below
            Image.asset("assets/images/img2.png"),
            const SizedBox(height: 12),
            Image.asset("assets/images/img2.png"),
          ],
        ),
      ),
    );
  }
}
