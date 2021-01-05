import 'package:flutter/material.dart';
import 'package:taskly/app/theme/color_theme.dart';

enum AppTheme {
  YellowLight,
  YellowDark,
  RedLight,
  RedDark,
  TealLight,
  TealDark,
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
  AppTheme.RedLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryRed,
    scaffoldBackgroundColor: white1,
    primaryColorLight: white2,
    primaryColorDark: secondaryDBlue,
  ),
  AppTheme.RedDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryRed,
    scaffoldBackgroundColor: primaryDBlue,
    primaryColorDark: white2,
    primaryColorLight: secondaryDBlue,
  ),
  AppTheme.TealLight: ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryTeal,
    scaffoldBackgroundColor: white1,
    primaryColorLight: white2,
    primaryColorDark: secondaryDBlue,
  ),
  AppTheme.TealDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryTeal,
    scaffoldBackgroundColor: primaryDGrey,
    primaryColorDark: white2,
    primaryColorLight: secondaryDGrey,
  ),
};
