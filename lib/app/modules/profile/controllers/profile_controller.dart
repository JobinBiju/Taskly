import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:taskly/app/data/model/user_model.dart';
import 'package:taskly/app/modules/home/controllers/home_controller.dart';
import 'package:taskly/app/theme/text_theme.dart';

class ProfileController extends GetxController {
  // instance of Get Storage
  final userData = GetStorage();

  // Hive DB
  String taskBox = 'tasks';

  // Text feild controllers for edit account
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;

  // list of state for gender toggleButton
  List<bool> selectedToggleGender;

  // userData
  String fName;
  String lName;
  String email;
  bool isMale;

  // instance of user model
  User user;

  //function to toggle gender in edit account
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

  @override
  void onInit() {
    super.onInit();
    getUser();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    selectedToggleGender = [false, false];
  }

  // function to get userInfo
  getUser() {
    fName = userData.read('fName');
    lName = userData.read('lName');
    email = userData.read('email');
    isMale = userData.read('isMale');
  }

  // function to reset userInfo
  resetUser() async {
    var box = await Hive.openBox(taskBox);
    userData.erase();
    await box.clear();
    Hive.close();
  }

  // function to get current userInfo for edit
  preEditUser() {
    firstNameController.text = fName;
    lastNameController.text = lName;
    emailController.text = email;
    if (isMale) {
      selectedToggleGender.first = true;
      selectedToggleGender.last = false;
    } else {
      selectedToggleGender.first = false;
      selectedToggleGender.last = true;
    }
  }

  // function to apply edited user details
  editUser() {
    if (validateCreds()) {
      HomeController c = Get.put(HomeController());
      user = User();
      user.firstName = firstNameController.text;
      user.lastName = lastNameController.text;
      user.email = emailController.text;
      user.isMale = selectedToggleGender.first;
      userData.write('fName', user.firstName);
      userData.write('lName', user.lastName);
      userData.write('email', user.email);
      userData.write('isMale', user.isMale);
      getUser();
      c.getUser();
      update([7, true]);
      Get.back();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  // function to return a customDialog for LogOut confirmation
  Future<dynamic> customDialogLogOut(BuildContext context) {
    return Get.dialog(Container(
      margin: EdgeInsets.symmetric(
          vertical: Get.height * 0.35, horizontal: Get.width * 0.18),
      padding: EdgeInsets.all(20),
      width: Get.width * 0.8,
      height: Get.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Log Out!',
                  style: kSubHeadTextStyle.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'This will erase all data.',
                  style: kSubHeadTextStyle.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                Text(
                  'Are you sure?',
                  style: kSubHeadTextStyle.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 140,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                'No',
                                style: kSubHeadTextStyle.copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: () async {
                            await resetUser();
                            Get.offAllNamed('/splash-screen');
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                'Yes',
                                style: kSubHeadTextStyle.copyWith(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              )),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
