import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskly/app/theme/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: appThemeData[AppTheme.YellowLight],
      debugShowCheckedModeBanner: false,
      title: "Taskly",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
