import 'package:get/get.dart';
import 'package:taskly/app/theme/app_theme.dart';

class SettingsController extends GetxController {
  var themes = [
    "Yellow Light",
    "Yellow Dark",
    "Red Light",
    "Red Dark",
    "Teal Light",
    "Teal Dark",
  ];
  var selectedTheme = "Yellow Light";

  changeTheme(String newValue) {
    selectedTheme = newValue;
    setTheme(newValue);
    update();
  }

  setTheme(String newTheme) {
    int n = themes.indexOf(newTheme);
    Get.changeTheme(appThemeData.values.elementAt(n));
  }

  @override
  void onInit() {}
  @override
  void onReady() {}
  @override
  void onClose() {}
}
