import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: ThemeData().copyWith(
        primaryColorLight: Color(0xFFF6C90E),
        primaryColorDark: Color(0xFF3A4750),
        primaryColorBrightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      title: "Taskly",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
