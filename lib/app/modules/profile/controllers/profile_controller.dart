import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:taskly/app/theme/text_theme.dart';

class ProfileController extends GetxController {
  // instance of Get Storage
  final userData = GetStorage();

  // Hive DB
  String taskBox = 'tasks';

  // userData
  String fName;
  String lName;
  String email;
  bool isMale;

  getUser() {
    fName = userData.read('fName');
    lName = userData.read('lName');
    email = userData.read('email');
    isMale = userData.read('isMale');
  }

  resetUser() async {
    var box = await Hive.openBox(taskBox);
    userData.erase();
    await box.clear();
    Hive.close();
  }

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

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
                  'Log Out',
                  style: kSubHeadTextStyle.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Are you sure?',
                  style: kSubHeadTextStyle.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                SizedBox(height: 40),
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
