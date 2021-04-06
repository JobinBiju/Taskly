import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  // instance of Get Storage
  final userData = GetStorage();

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

  resetUser() {
    userData.remove('fName');
    userData.remove('lName');
    userData.remove('email');
    userData.remove('isMale');
    userData.write('loginStatus', false);
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
}
