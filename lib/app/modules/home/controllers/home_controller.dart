import 'package:get/get.dart';

class HomeController extends GetxController {
  var _currentIndex = 0.obs;
  get currentIndex => this._currentIndex.value;
  set currentIndex(index) => this._currentIndex.value = index;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}
  @override
  void onClose() {}
}
