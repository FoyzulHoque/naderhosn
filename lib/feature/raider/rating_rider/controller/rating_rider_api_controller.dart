import 'package:get/get.dart';

import '../../../../core/network_caller/endpoints.dart';
import '../../../../core/network_caller/network_config.dart';

class RatingRiderApiController extends GetxController{
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

Future<bool> ratingRiderApiMethod(String id, int rating, String comment)async{
  bool isSuccess = false;
  _isLoading=true;
  update();
  Map<String, dynamic> requestBody = {
    "carTransportId": id,
    "rating": rating,
    "comment": comment
  };
  NetworkResponse response = await NetworkCall.postRequest(url: Urls.reviewsCreate, body: requestBody);
if(response.isSuccess){
  _errorMessage=null;
  isSuccess=true;
}else{
  _errorMessage=response.errorMessage;
}
  _isLoading=false;
  update();
  return isSuccess;

}
}