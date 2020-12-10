import 'package:flutter/material.dart';
import 'package:taskly/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        primaryColorLight: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
