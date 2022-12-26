import 'package:flutter/material.dart';
import 'appcolor.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Satoshi',
  brightness: Brightness.light,
  primaryColor: AppColorLight.primary,
  backgroundColor: AppColorLight.background,
  // appBarTheme: AppBarTheme(
  //   backgroundColor: AppColorLight.primary,
  //   elevation: 0.0,
  // ),
  scaffoldBackgroundColor: AppColorLight.background,
  dividerColor: AppColorLight.outline,
  hintColor: AppColorLight.outline,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColorLight.primary,
    selectionColor: AppColorLight.primaryContainer,
    selectionHandleColor: AppColorLight.primary,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: AppColorLight.onBackground,
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
    bodyText1: TextStyle(
      color: AppColorLight.secondary,
      fontSize: 17.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    bodyText2: TextStyle(
      color: AppColorLight.secondary,
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  //fontFamily: 'Roboto',
  brightness: Brightness.dark,
  primaryColor: AppColorDark.primary,
  backgroundColor: AppColorDark.background,
  // appBarTheme: AppBarTheme(
  //   backgroundColor: AppColorLight.primary,
  //   elevation: 0.0,
  // ),
  scaffoldBackgroundColor: AppColorDark.background,
  dividerColor: AppColorDark.outline,
  hintColor: AppColorDark.outline,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColorDark.primary,
    selectionColor: AppColorDark.primaryContainer,
    selectionHandleColor: AppColorDark.primary,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: AppColorDark.onBackground,
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
    bodyText1: TextStyle(
      color: AppColorDark.secondary,
      fontSize: 17.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    bodyText2: TextStyle(
      color: AppColorDark.secondary,
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  ),
);
