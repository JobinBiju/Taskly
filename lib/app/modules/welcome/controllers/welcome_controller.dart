import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  List<bool> selectedToggleGender;

  // Text feild controllers for login.
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    selectedToggleGender = [false, false];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    firstNameController?.dispose();
    lastNameController?.dispose();
    emailController?.dispose();
  }

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
