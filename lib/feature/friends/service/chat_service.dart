import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel _channel;

  Future<void> connect(String url, String token) async {
    _channel = WebSocketChannel.connect(Uri.parse('$url?token=$token'));
    await _channel.ready;
    _authenticate(token);
  }

  void _authenticate(String token) {
    final authMessage = jsonEncode({"event": "authenticate", "token": token});
    _channel.sink.add(authMessage);
    if (kDebugMode) {
      print("Sent authentication message: $authMessage");
    }
  }

  Stream get messages => _channel.stream;

  void sendMessage(String event, Map<String, dynamic> data) {
    final message = jsonEncode({"event": event, ...data});
    _channel.sink.add(message);
    if (kDebugMode) {
      print("Sent WebSocket message: $message");
    }
  }

  void close() {
    if (kDebugMode) {
      print("Closing WebSocket connection.");
    }
    _channel.sink.close();
  }
}