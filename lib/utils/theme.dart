import 'package:flutter/material.dart';

import 'constants.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.BACKGROUND_COLOR,
  unselectedWidgetColor: AppColors.GREY_COLOR,
  fontFamily: 'Lato',
  primaryColor: AppColors.PRIMARY_COLOR,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.PRIMARY_COLOR,
    onPrimary: AppColors.WHITE_COLOR,
    secondary: AppColors.SECONDARY_LIGHT,
    onSecondary: AppColors.SECONDARY_COLOR,
    error: AppColors.ERROR_COLOR,
    onError: Colors.redAccent,
    background: AppColors.BACKGROUND_COLOR,
    onBackground: AppColors.BLACK_COLOR,
    surface: AppColors.BORDER_COLOR,
    onSurface: AppColors.PRIMARY_COLOR,
    primaryContainer: AppColors.PRIMARY_COLOR,
  ),
  indicatorColor: AppColors.GREY_COLOR,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w800,
      color: AppColors.BLACK_COLOR,
      letterSpacing: .75,
    ),
    headlineMedium: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
      color: AppColors.BLACK_COLOR,
      letterSpacing: .75,
    ),
    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: AppColors.BLACK_COLOR,
      letterSpacing: .75,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.BLACK_COLOR,
      letterSpacing: .75,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.PRIMARY_COLOR,
      foregroundColor: AppColors.WHITE_COLOR,
    ),
  ),
);

final darkTheme = ThemeData(
  fontFamily: 'Lato',
  scaffoldBackgroundColor: AppColors.BACKGROUND_DARK,
  unselectedWidgetColor: AppColors.GREY_COLOR,
  primaryColor: AppColors.PRIMARY_DARK,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.PRIMARY_DARK,
    onPrimary: AppColors.GREY_COLOR,
    secondary: AppColors.PRIMARY_DARK,
    onSecondary: AppColors.GREY_COLOR,
    error: AppColors.ERROR_COLOR,
    onError: Colors.redAccent,
    background: AppColors.BACKGROUND_COLOR,
    onBackground: AppColors.GREY_COLOR,
    surface: AppColors.BORDER_COLOR,
    onSurface: AppColors.NAVIGATION_BAR_DARK,
    primaryContainer: AppColors.BACKGROUND_DARK,
  ),
  indicatorColor: AppColors.PRIMARY_DARK,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w800,
      color: AppColors.WHITE_COLOR,
      letterSpacing: 0.75,
    ),
    headlineMedium: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w400,
      color: AppColors.WHITE_COLOR,
      letterSpacing: 0.75,
    ),
    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: AppColors.GREY_COLOR,
      letterSpacing: 0.75,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.GREY_COLOR,
      letterSpacing: 0.75,
    ),
  ),
);
