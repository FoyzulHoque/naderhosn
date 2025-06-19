import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/core/style/global_text_style.dart';

class ResetPinSeedPhraseController extends GetxController {
  var enteredPhrase = ''.obs;
  var words = [
    'Basket',
    'Select',
    'Bicycle',
    'Chair',
    'Random',
    'Offer',
    'Recover',
    'Typist',
    'Sacrifice',
  ];

  // Function to update the entered phrase
  void updateEnteredPhrase(String word) {
    if (enteredPhrase.value.isEmpty) {
      enteredPhrase.value = word; // Add the first word
    } else {
      enteredPhrase.value =
          '${enteredPhrase.value} $word'; // Append the clicked word
    }
  }

  // Function to clear the entered phrase
  void clearEnteredPhrase() {
    enteredPhrase.value = '';
  }
}

// Assuming you have this custom button

class ResetPinEnterSeedPhrase extends StatelessWidget {
  ResetPinEnterSeedPhrase({super.key});

  final ResetPinSeedPhraseController controller = Get.put(
    ResetPinSeedPhraseController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff334155), size: 24),
          onPressed: () {
            // Handle back button action
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 0,
            bottom: 50,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Enter your seed phrase",
                style: globalTextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Enter your seed phrase in order in the space provided below:",
                style: globalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff636F85),
                ),
              ),
              SizedBox(height: 24),
              DottedBorder(
                dashPattern: [10],
                color: Color(0xFF6056DD),
                strokeWidth: 1,
                borderType: BorderType.RRect,
                radius: Radius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(
                              text: controller.enteredPhrase.value,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter seed phrase here',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            maxLines: 5,
                            readOnly: true, // Make the TextField read-only
                          ),
                        ),
                        GestureDetector(
                          onTap: controller.clearEnteredPhrase,
                          child: Icon(
                            Icons.close,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(height: 20),
              // Display seed words as buttons in grid layout
              GridView.builder(
                shrinkWrap:
                    true, // Ensure the grid takes as much space as needed
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 items per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.words.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () =>
                        controller.updateEnteredPhrase(controller.words[index]),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFBDA1F8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      controller.words[index],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              // Confirm button disabled if no text in TextField
              // Obx(() {
              //   bool isConfirmButtonEnabled =
              //       controller.enteredPhrase.value.isNotEmpty;

              //   return CustomButton2(
              //     title: 'Proceed',
              //     backgroundColor:
              //         isConfirmButtonEnabled
              //             ? Color(0xff6056DD)
              //             : Color(0xFFBDA1F8),
              //     onPress:
              //         isConfirmButtonEnabled
              //             ? () {
              //               Get.to(CreatePin());
              //             }
              //             : () {}, // Provide an empty function when the button is disabled
              //   );
              // }),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
