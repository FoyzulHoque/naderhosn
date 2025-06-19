import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/style/global_text_style.dart';
import 'package:naderhosn/feature/user/home/screen/home.dart';

class MoodBoardSender extends StatefulWidget {
  const MoodBoardSender({super.key});

  @override
  _MoodBoardState createState() => _MoodBoardState();
}

class _MoodBoardState extends State<MoodBoardSender> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> imageList = [
    "assets/images/onboard1.png",
    "assets/images/onboard2.png",
    "assets/images/onboard3.png",
  ];

  void _nextPage() {
    if (_currentIndex < imageList.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      print("Done pressed");
      Get.to(() => HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // PageView from image list
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  "assets/images/back_button.png",
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: imageList.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(imageList[index], width: size.width * 0.9),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dot indicator and button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dot indicators
                  Row(
                    children: List.generate(imageList.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Color(0xFF3BD85E)
                              : Color(0xFFA5EDB5),
                        ),
                      );
                    }),
                  ),

                  // Next / Done button
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: Color(0xFF3BD85E),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentIndex == imageList.length - 1
                          ? "Get Started"
                          : "Next",
                      style: globalTextStyle(
                        color: Color(0xFF0E1011),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
