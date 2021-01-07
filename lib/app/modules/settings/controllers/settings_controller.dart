import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskly/app/theme/app_theme.dart';

class SettingsController extends GetxController {
  final userData = GetStorage();

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
  String selectedTheme;

  // function to change theme on settings
  changeTheme(String newValue) {
    selectedTheme = newValue;
    userData.write('theme', newValue);
    int n = themes.indexOf(newValue);
    Get.changeTheme(appThemeData.values.elementAt(n));
    update();
  }

  @override
  void onInit() {
    super.onInit();
    selectedTheme = userData.read('theme');
  }

  @override
  void onReady() {}
  @override
  void onClose() {}
}
