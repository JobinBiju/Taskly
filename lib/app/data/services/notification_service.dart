import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationPlugin {
  // Notification controller
  FlutterLocalNotificationsPlugin fNotification;

  NotificationPlugin() {
    init();
  }
  Future onNotificationSelected(String payload) {
    return showDialog(
        context: Get.context,
        builder: (context) => AlertDialog(
              content: Text('Notify $payload'),
            ));
  }

  Future showNotification() async {
    //var scheduledTime = DateTime.now().add(Duration(seconds: 5));

    var androidDetails = AndroidNotificationDetails(
      'Channel ID 0',
      'Drink Water',
      'Drink Water Notification',
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

    // Function to periodically show notification
    await fNotification.periodicallyShow(
      1,
      'Drink Water',
      'Keep Yourself Hydrated',
      RepeatInterval.hourly,
      generalNotificationDetails,
      payload: "Drink Water",
      androidAllowWhileIdle: true,
    );

    // await fNotification.schedule(
    //   1,
    //   "Drink",
    //   "Drink Water",
    //   scheduledTime,
    //   generalNotificationDetails,
    // );
  }

  Future cancelDrinkwaterNotifucation() async {
    await fNotification.cancel(1);
  }

  void init() {
    // notification config
    fNotification = FlutterLocalNotificationsPlugin();
    var androidInitialize = AndroidInitializationSettings('app_icon');
    var iOSInitialize = IOSInitializationSettings();
    var initializationSetting = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );
    fNotification.initialize(
      initializationSetting,
      onSelectNotification: onNotificationSelected,
    );
  }
}
