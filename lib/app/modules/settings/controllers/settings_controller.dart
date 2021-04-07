import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskly/app/data/services/notification_service.dart';
import 'package:taskly/app/theme/app_theme.dart';

class SettingsController extends GetxController {
  // instance of Get Storage
  final userData = GetStorage();

  // store selectedTheme
  String selectedTheme;

  // store state of drinkWaterNotify
  bool drinkWater;

  // instance of Notification service
  NotificationPlugin nPlugin = NotificationPlugin();

  // list of available in the respective order of app theme in theme/app_theme.dart
  var themes = [
    "Yellow Light",
    "Yellow Dark",
    "Red Light",
    "Red Dark",
    "Teal Light",
    "Teal Dark",
    "Green Light",
    "Green Dark",
  ];

  // function to change theme on settings
  changeTheme(String newValue) {
    selectedTheme = newValue;
    userData.write('theme', newValue);
    int n = themes.indexOf(newValue);
    Get.changeTheme(appThemeData.values.elementAt(n));
    update();
  }

  // Drink water notification toggle
  toggleWater(bool value) async {
    drinkWater = value;
    userData.write('drinkWater', value);
    if (value == true) {
      await nPlugin.showNotification();
    } else {
      nPlugin.onCancelNotifucation();
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    selectedTheme = userData.read('theme');
    drinkWater = userData.read('drinkWater');
    nPlugin.init();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
