import 'package:aetherium_salon/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

var appTheme = ThemeData(
  fontFamily: GoogleFonts.nunito().fontFamily,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: whiteColor,
    secondary: secondaryColor,
    onSecondary: secondaryColor,
    error: redColor,
    onError: redColor,
    background: whiteColor,
    onBackground: whiteColor,
    surface: whiteColor,
    onSurface: blackColor,
  ),
  primaryColor: primaryColor,
  secondaryHeaderColor: whiteColor,
  iconTheme: const IconThemeData(color: primaryColor),
  tabBarTheme: const TabBarTheme(labelColor: Colors.black),
  listTileTheme: const ListTileThemeData(iconColor: blackColor),
  brightness: Brightness.light,
  dividerColor: transparent,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: primaryColor),
    titleTextStyle: TextStyle(color: primaryColor),
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: whiteColor,
    selectedItemColor: bottomSelectedColor,
    unselectedItemColor: bottomUnselectedColor,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.black87,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(fontSize: 18),
    bodyText2: TextStyle(fontSize: 16),
    button: TextStyle(
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
    headline1: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: Colors.grey,
    ),
  ),
  buttonTheme: const ButtonThemeData(),
);
