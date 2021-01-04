import 'package:flutter/material.dart';
import 'package:taskly/app/theme/color_theme.dart';

enum AppTheme {
  YellowLight,
  YellowDark,
  RedLight,
  RedDark,
}

final appThemeData = {
  AppTheme.YellowLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryYellow,
    scaffoldBackgroundColor: white1,
    primaryColorLight: white2,
    primaryColorDark: secondaryGrey,
  ),
  AppTheme.YellowDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: secondaryYellow,
    scaffoldBackgroundColor: primaryGrey,
    primaryColorDark: white2,
    primaryColorLight: secondaryGrey,
  ),
};
