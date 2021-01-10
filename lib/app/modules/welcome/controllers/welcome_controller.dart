import 'package:get/get.dart';

class WelcomeController extends GetxController {
  List<bool> selectedToggleGender;
  @override
  void onInit() {
    super.onInit();
    selectedToggleGender = [false, false];
  }

  @override
  void onReady() {}
  @override
  void onClose() {}
  onToggledGender(int index) {
    if (index == 0) {
      selectedToggleGender[index] = !selectedToggleGender[index];
      if (selectedToggleGender[index] == true) {
        selectedToggleGender[1] = false;
      }
    }
    if (index == 1) {
      selectedToggleGender[index] = !selectedToggleGender[index];
      if (selectedToggleGender[index] == true) {
        selectedToggleGender[0] = false;
      }
    }
    update();
  }
}
