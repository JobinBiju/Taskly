import 'package:get/get.dart';

import 'package:taskly/app/modules/home/bindings/home_binding.dart';
import 'package:taskly/app/modules/home/views/home_view.dart';
import 'package:taskly/app/modules/profile/bindings/profile_binding.dart';
import 'package:taskly/app/modules/profile/views/profile_view.dart';
import 'package:taskly/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:taskly/app/modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
