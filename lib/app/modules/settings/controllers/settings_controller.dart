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
    "Green Light",
    "Green Dark",
  ];
  String selectedTheme;

  changeTheme(String newValue) {
    selectedTheme = newValue;
    int n = themes.indexOf(newValue);
    Get.changeTheme(appThemeData.values.elementAt(n));
    update();
  }

  @override
  void onInit() {
    super.onInit();
    selectedTheme = themes.first;
  }

  @override
  void onReady() {}
  @override
  void onClose() {}
}
