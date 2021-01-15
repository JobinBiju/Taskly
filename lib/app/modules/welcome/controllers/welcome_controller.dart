import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  List<bool> selectedToggleGender;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    selectedToggleGender = [false, false];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  //function to toggle gender in log in screen
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
