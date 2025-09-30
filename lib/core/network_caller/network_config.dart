/*

import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';
import 'package:http/http.dart' as http; // ✅ FIXED: added to use http.MultipartRequest
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import '../../feature/auth/login/view/login_view.dart';
import '../services_class/data_helper.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final String? errorMessage;
  final bool isSuccess;

  NetworkResponse({
    required this.statusCode,
    this.responseData,
    this.errorMessage = "Request failed !",
    required this.isSuccess,
  });
}

class NetworkCall {
  static final Logger _logger = Logger(); // ✅ Fixed: made static
  //String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4ODY3NzEwZmJhMTU1NWY5NDJjMzkwMiIsImVtYWlsIjoicmFmc2Fuc2F5ZWQxMzJAZ21haWwuY29tIiwicm9sZSI6IkNsaWVudCIsImlhdCI6MTc1NzYxMzg1NiwiZXhwIjoxNzg5MTQ5ODU2fQ.p9JRWupKDpL-8bfYF0u3QMp_9cBfgp4orY-RjWOpxVc";


  /// POST request

  static Future<NetworkResponse> multipartRequest({
    required String url,
    Map<String, String>? fields, // 👈 form fields (not dynamic)
    File? imageFile, // 👈 optional image
    File? videoFile, // 👈 optional video
    required String methodType
  }) async {
    try {
      final Uri uri = Uri.  parse(url);
      var request = http.MultipartRequest(methodType, uri);
      //final  dataHelperController = Get.find<DataHelperController>();

      // ✅ Header set without content-type
      request.headers.addAll({
        'Authorization': '${AuthController.accessToken ?? ''}',
      });

      // ✅ Add fields (e.g. name, email)
      if (fields != null) {
        request.fields.addAll(fields);
      }

      // ✅ Attach image if present
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image', // 👈 API expects this name
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      // ✅ Attach video if present
      if (videoFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'video', // 👈 API expects this name
          videoFile.path,
          contentType: MediaType('video', 'mp4'),
        ));
      }

      // ✅ Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }




  /// POST request


  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
    // final dataHelperController = Get.find<DataHelperController>();

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      // Only add token if it exists
      if (AuthController.accessToken != null &&
          AuthController.accessToken!.isNotEmpty) {
        headers['Authorization'] = AuthController.accessToken!;
      }

      print("Token===${AuthController.accessToken}");
      _logRequest(url, headers, requestBody: body);

      Response response =
      await post(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response);
      print("status code net=${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }


   static Future<NetworkResponse> patchRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
     // final dataHelperController = Get.find<DataHelperController>();

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      // Only add token if it exists
      if (AuthController.accessToken != null &&
          AuthController.accessToken!.isNotEmpty) {
        headers['Authorization'] = AuthController.accessToken!;
      }

      print("Token===${AuthController.accessToken}");
      _logRequest(url, headers, requestBody: body);

      Response response =
      await patch(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }


  /// GET request
  static Future<NetworkResponse> getRequest({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      String fullUrl = url;
      if (queryParams != null && queryParams.isNotEmpty) {
        fullUrl += '?';
        queryParams.forEach((key, value) {
          fullUrl += '$key=$value&';
        });
        fullUrl = fullUrl.substring(0, fullUrl.length - 1); // remove trailing &
      }

      final Uri uri = Uri.parse(fullUrl);
      //final  dataHelperController = Get.find<DataHelperController>();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Authorization': '${AuthController.accessToken ?? ''}'
      };

      _logRequest(fullUrl, headers);
      Response response = await get(uri, headers: headers);
      _logResponse(fullUrl, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// PATCH request
  static Future<NetworkResponse> putRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      //final  dataHelperController = Get.find<DataHelperController>();


      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Authorization': '${AuthController.accessToken ?? ''}'
      };

      _logRequest(url, headers, requestBody: body);
      Response response = await put(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }



  /// DELETE request
  static Future<NetworkResponse> deleteRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
     // final  dataHelperController = Get.find<DataHelperController>();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Authorization': '${AuthController.accessToken??''}'
      };

      _logRequest(url, headers, requestBody: body);
      Response response = await delete(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Logging request
  static void _logRequest(String url, Map<String, dynamic> headers,
      {Map<String, dynamic>? requestBody}) {
    _logger.i("🌐 REQUEST\nURL: $url\nHeaders: $headers\nBody: ${jsonEncode(requestBody)}");
  }

  /// Logging response
  static void _logResponse(String url, Response response) {
    _logger.i("📥 RESPONSE\nURL: $url\nStatus Code: ${response.statusCode}\nBody: ${response.body}");
  }

  /// Logout and navigate to login
  static Future<void> _logOut() async {
    //final  dataHelperController = Get.find<DataHelperController>();

    await AuthController.dataClear();
    Get.offAll(LoginView());
    */
/* Navigator.pushAndRemoveUntil(
      MyApp.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => LoginView()),
          (_) => false,
    );*//*

  }



  static Future<NetworkResponse> putMultipartRequest({
    required String url,
    required File file, // 👈 the image file to send
    String? fieldName = 'file', // 👈 optional field name (default: 'file')
    Map<String, String>? fields, // 👈 additional text fields
  }) async {
    try {
      final Uri uri = Uri.parse(url);

      final request = http.MultipartRequest('PUT', uri);
     // final  dataHelperController = Get.find<DataHelperController>();

      // ✅ Token header
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = AuthController.accessToken??'';


      // ✅ Attach image file
      request.files.add(
        await http.MultipartFile.fromPath(fieldName!, file.path),
      );

      // ✅ Add optional fields (e.g. name, email)
      if (fields != null) {
        request.fields.addAll(fields);
      }

      _logRequest(url, request.headers, requestBody: fields);
      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: response.body,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

}*/
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import '../../feature/auth/login/view/login_view.dart';
import '../services_class/data_helper.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final String? errorMessage;
  final bool isSuccess;

  NetworkResponse({
    required this.statusCode,
    this.responseData,
    this.errorMessage = "Request failed !",
    required this.isSuccess,
  });
}

class NetworkCall {
  static final Logger _logger = Logger();

  /// POST Multipart request
  static Future<NetworkResponse> multipartRequest({
    required String url,
    Map<String, String>? fields,
    File? imageFile,
    File? videoFile,
    required String methodType,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      var request = http.MultipartRequest(methodType, uri);

      // Add Authorization header
      if (AuthController.accessToken != null &&
          AuthController.accessToken!.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer ${AuthController.accessToken!}';
      }

      // Add fields (e.g. name, email)
      if (fields != null) {
        request.fields.addAll(fields);
      }

      // Attach image if present
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      // Attach video if present
      if (videoFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'video',
          videoFile.path,
          contentType: MediaType('video', 'mp4'),
        ));
      }

      // Send request
      _logRequest(url, request.headers, requestBody: fields);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// POST request
  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      // Only add token if it exists
      if (AuthController.accessToken != null &&
          AuthController.accessToken!.isNotEmpty) {
        headers['Authorization'] = AuthController.accessToken!;
      }

      _logRequest(url, headers, requestBody: body);

      Response response = await post(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );

      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// PATCH request
  static Future<NetworkResponse> patchRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      if (AuthController.accessToken != null &&
          AuthController.accessToken!.isNotEmpty) {
        headers['Authorization'] = AuthController.accessToken!;
      }

      _logRequest(url, headers, requestBody: body);
      Response response = await patch(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// GET request
  static Future<NetworkResponse> getRequest({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      String fullUrl = url;
      if (queryParams != null && queryParams.isNotEmpty) {
        fullUrl += '?';
        queryParams.forEach((key, value) {
          fullUrl += '$key=$value&';
        });
        fullUrl = fullUrl.substring(0, fullUrl.length - 1);
      }

      final Uri uri = Uri.parse(fullUrl);
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      if (AuthController.accessToken != null &&
          AuthController.accessToken!.isNotEmpty) {
        headers['Authorization'] = AuthController.accessToken!;
      }

      _logRequest(fullUrl, headers);
      Response response = await get(uri, headers: headers);
      _logResponse(fullUrl, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// PUT request
  static Future<NetworkResponse> putRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      if (AuthController.accessToken != null &&
          AuthController.accessToken!.isNotEmpty) {
        headers['Authorization'] = AuthController.accessToken!;
      }

      _logRequest(url, headers, requestBody: body);
      Response response = await put(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// DELETE request
  static Future<NetworkResponse> deleteRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };
      if (AuthController.accessToken != null &&
          AuthController.accessToken!.isNotEmpty) {
        headers['Authorization'] = AuthController.accessToken!;
      }

      _logRequest(url, headers, requestBody: body);
      Response response = await delete(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// PUT Multipart request
  static Future<NetworkResponse> putMultipartRequest({
    required String url,
    required File file,
    String? fieldName = 'file',
    Map<String, String>? fields,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      final request = http.MultipartRequest('PUT', uri);

      // Token header
      request.headers['Accept'] = 'application/json';
      if (AuthController.accessToken != null &&
          AuthController.accessToken!.isNotEmpty) {
        request.headers['Authorization'] = AuthController.accessToken!;
      }

      // Attach image file
      request.files.add(
        await http.MultipartFile.fromPath(fieldName!, file.path),
      );

      // Add optional fields
      if (fields != null) {
        request.fields.addAll(fields);
      }

      _logRequest(url, request.headers, requestBody: fields);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseDecode = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseDecode,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: response.statusCode, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Logging request
  static void _logRequest(String url, Map<String, dynamic> headers,
      {Map<String, dynamic>? requestBody}) {
    _logger.i(
        "🌐 REQUEST\nURL: $url\nHeaders: $headers\nBody: ${jsonEncode(requestBody)}");
  }

  /// Logging response
  static void _logResponse(String url, Response response) {
    _logger.i(
        "📥 RESPONSE\nURL: $url\nStatus Code: ${response.statusCode}\nBody: ${response.body}");
  }

  /// Logout and navigate to login
  static Future<void> _logOut() async {
    await AuthController.dataClear();
    Get.offAll( LoginView());
  }
}