/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naderhosn/feature/raider/chat/controller/chat_controller.dart';

import '../../../friends/controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    child: Align(
                      alignment: message.isSentByUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: size.width * 0.6,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: message.isSentByUser
                              ? Colors.white
                              : Colors.yellow[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: message.isSentByUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(message.text, style: TextStyle(fontSize: 16)),
                            SizedBox(height: 5),
                            Text(
                              message.time,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Image.asset(
                  "assets/images/send.png",
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
