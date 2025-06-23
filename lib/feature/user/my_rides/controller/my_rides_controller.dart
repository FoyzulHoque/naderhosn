import 'package:get/get.dart';

class MyRidesController extends GetxController {
  var currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    ever(currentTabIndex, (index) {});
  }
}
