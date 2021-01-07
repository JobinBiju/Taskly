import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/app/modules/home/views/dashboard_view.dart';
import 'package:taskly/app/modules/home/views/today_task_view.dart';

class HomeController extends GetxController {
  var _currentIndex = 0.obs;
  get currentIndex => this._currentIndex.value;
  set currentIndex(index) => this._currentIndex.value = index;

  // the list of screens switched by bottom navBar
  final List<Widget> homeViews = [
    DashboardView(),
    TodayTaskView(),
  ];

  // function to return correct view on bottom navBar switch
  Widget navBarSwitcher() {
    return homeViews.elementAt(currentIndex);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}
  @override
  void onClose() {}
}
