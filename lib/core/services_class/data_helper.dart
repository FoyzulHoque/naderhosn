import 'dart:convert';
import 'package:naderhosn/feature/auth/login/model/rider_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String? accessToken;
  static RiderModel? userModel;
  static String? accessKey;

  static const String _userIdKey = 'userId';
  static const String _accessTokenKey = 'access-token';
  static const String _userDataKey = 'user-data';

  /// Save token + user model
  static Future<void> setUserData(String token, RiderModel model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    await prefs.setString(_userDataKey, jsonEncode(model.toJson()));

    // ✅ Automatically save user ID if available
    if (model.id != null && model.id!.isNotEmpty) {
      await prefs.setString(_userIdKey, model.id!);
    }

    accessToken = token;
    userModel = model;
  }

  /// Load user data from local storage
  static Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_accessTokenKey);
    final userData = prefs.getString(_userDataKey);

    if (userData != null) {
      accessToken = token;
      userModel = RiderModel.fromJson(jsonDecode(userData));
    }
  }

  /// Save user ID separately (optional)
  static Future<void> saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, id);
  }

  /// Get user ID
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  /// Check login status
  static Future<bool> isUserLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_accessTokenKey);
    if (token != null) {
      await getUserData();
      return true;
    }
    return false;
  }

  /// Logout → clear all saved data
  static Future<void> dataClear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    accessToken = null;
    userModel = null;
    accessKey = null;
  }
}
