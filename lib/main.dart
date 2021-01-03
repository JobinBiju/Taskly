import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData().copyWith(
        primaryColorLight: Color(0xFFF6C90E),
        primaryColorDark: Color(0xFF3A4750),
        primaryColorBrightness: Brightness.light,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "Taskly",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
