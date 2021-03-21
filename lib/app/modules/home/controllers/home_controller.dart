import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:taskly/app/data/services/time_zone.dart';
import 'package:taskly/app/modules/home/views/dashboard_view.dart';
import 'package:taskly/app/modules/home/views/today_task_view.dart';
import 'package:timezone/timezone.dart' as tz;

class HomeController extends GetxController {
  // bottom nav current index.
  var _currentIndex = 0.obs;
  get currentIndex => this._currentIndex.value;
  set currentIndex(index) => this._currentIndex.value = index;

  // Notification controller
  FlutterLocalNotificationsPlugin fNotification;

  // the list of screens switched by bottom navBar
  final List<Widget> homeViews = [
    DashboardView(),
    TodayTaskView(),
  ];

  // function to return correct view on bottom navBar switch
  Widget navBarSwitcher() {
    return homeViews.elementAt(currentIndex);
  }

  Future notificationSelected(String payload) {
    showDialog(
        context: Get.context,
        builder: (context) => AlertDialog(
              content: Text('Notify $payload'),
            ));
  }

  Future showNotification() async {
    var scheduledTime = DateTime.now().add(Duration(seconds: 5));

    var androidDetails = AndroidNotificationDetails(
      'Channel ID 1',
      'Test Notify',
      'Hello! My first notification',
      importance: Importance.max,
      priority: Priority.high,
      timeoutAfter: 3000,
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      enableLights: true,
      enableVibration: true,
      ledColor: Color.fromARGB(255, 255, 0, 255),
      ledOnMs: 1000,
      ledOffMs: 500,
    );
    var iOSDetails = IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await fNotification.periodicallyShow(
      0,
      'Drink Water',
      'Keep yourself hydrated',
      RepeatInterval.everyMinute,
      generalNotificationDetails,
      payload: "Tasks",
    );

    // await fNotification.schedule(
    //   1,
    //   "Drink",
    //   "Drink Water",
    //   scheduledTime,
    //   generalNotificationDetails,
    // );
  }

  @override
  void onInit() {
    super.onInit();

    // notification config
    var androidInitialize = AndroidInitializationSettings('app_icon');
    var iOSInitialize = IOSInitializationSettings();
    var initializationSetting =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    fNotification = FlutterLocalNotificationsPlugin();
    fNotification.initialize(
      initializationSetting,
      onSelectNotification: notificationSelected,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
