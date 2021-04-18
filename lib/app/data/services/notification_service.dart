import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:taskly/app/data/model/task_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
    var androidDetails = AndroidNotificationDetails(
      'Channel ID 0',
      'Drink Water',
      'Drink Water Notification',
      importance: Importance.max,
      priority: Priority.high,
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
      10001,
      'Drink Water',
      'Keep Yourself Hydrated',
      RepeatInterval.hourly,
      generalNotificationDetails,
      payload: "Drink Water",
      androidAllowWhileIdle: true,
    );
  }

  Future cancelDrinkwaterNotifucation() async {
    await fNotification.cancel(10001);
  }

  Future showTaskNotification(Task task, int id) async {
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    final location = tz.getLocation(currentTimeZone);
    var scheduledTime = tz.TZDateTime.from(task.taskDate, location)
        .add(const Duration(seconds: 5));

    var androidDetails = AndroidNotificationDetails(
      "Channel ID 2",
      task.taskTitle,
      task.taskDesc,
      importance: Importance.max,
      priority: Priority.high,
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

    await fNotification.zonedSchedule(
      id,
      task.taskTitle,
      task.taskDesc,
      scheduledTime,
      generalNotificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: task.taskTitle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future cancelTaskNotifucation(int id) async {
    await fNotification.cancel(id);
  }

  void init() {
    tz.initializeTimeZones();
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
