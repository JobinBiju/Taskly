import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController animationController;

  final count = 0.obs;
  @override
  void onInit() {
    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    Timer(
      Duration(milliseconds: 8200),
      () => Get.offNamed('/home'),
    );
    super.onInit();
  }

  @override
  void onReady() {}
  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
