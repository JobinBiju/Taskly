import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskly/app/data/model/user_model.dart';
import 'package:taskly/app/modules/home/views/home_view.dart';

class WelcomeController extends GetxController {
  List<bool> selectedToggleGender;

  // Text feild controllers for login.
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;

  // instance of Get Storage
  final userData = GetStorage();

  // stire loginStatus
  bool isLoggedIn;

  // instance of userData model
  User user;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    selectedToggleGender = [false, false];
    userData.writeIfNull('fName', 'Name');
    userData.writeIfNull('lName', 'SurName');
    userData.writeIfNull('email', 'name@example.com');
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
    update([5, true]);
  }

  // FirstName validator
  String fNameValidator(String value) {
    if (value.isEmpty) {
      return 'Enter your first name';
    }
    if (value.isAlphabetOnly) {
      return null;
    } else
      return 'Enter a valid name';
  }

  // LastName validator
  String lNameValidator(String value) {
    if (value.isEmpty) {
      return null;
    }
    if (value.isAlphabetOnly) {
      return null;
    } else
      return 'Enter a valid name';
  }

  // Email validator
  String emailValidator(String value) {
    if (value.isEmpty) {
      return 'Enter your email';
    }
    if (value.isEmail) {
      return null;
    } else
      return 'Enter a valid email';
  }

  // function to validate creds
  bool validateCreds() {
    bool validated = false;
    if (fNameValidator(firstNameController.text) == null &&
        lNameValidator(lastNameController.text) == null &&
        emailValidator(emailController.text) == null &&
        selectedToggleGender.contains(true)) {
      validated = true;
    } else {
      validated = false;
    }
    return validated;
  }

  // function to login to app
  userLogin() {
    if (validateCreds()) {
      user = User();
      user.firstName = firstNameController.text;
      user.lastName = lastNameController.text;
      user.email = emailController.text;
      user.isMale = selectedToggleGender.first;
      userData.write('fName', user.firstName);
      userData.write('lName', user.lastName);
      userData.write('email', user.email);
      userData.write('isMale', user.isMale);
      userData.write('loginStatus', true);
      Get.offAll(() => HomeView());
    }
  }
}
