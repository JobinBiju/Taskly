import 'package:get/get.dart';

import 'package:taskly/app/modules/splash_screen/controllers/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(
      () => SplashScreenController(),
    );
  }
}
