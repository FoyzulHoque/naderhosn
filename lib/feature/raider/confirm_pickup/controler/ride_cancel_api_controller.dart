import 'package:get/get.dart';
import 'package:naderhosn/core/network_caller/network_config.dart';
import 'package:naderhosn/core/services_class/data_helper.dart';

import '../../../../core/network_caller/endpoints.dart';
import '../model/cansele_model.dart';

class RideCancelApiController extends GetxController{

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool? _isLoading=false;
  bool? get isLoading => _isLoading;
  CancelRideModel? cancelRideModel;
  Future<bool> rideCancelApiMethod(String id) async {
    bool isSuccess = false;
    _isLoading = true;
    update();
    Map<String, dynamic> mapBody = {
      "cancelReason": "Changed my mind"
    };
    NetworkResponse response = await NetworkCall.patchRequest(
        url: Urls.riderRideCancel(id), body: mapBody,);

    if (response.isSuccess) {
      await CancelRideModel.fromJson(response.responseData!['data']);
      await AuthController.accessToken;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _isLoading = false;
    update();
    return isSuccess;
  }
}