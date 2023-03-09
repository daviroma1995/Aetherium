import 'package:aetherium_salon/utils/colors.dart';
import 'package:aetherium_salon/utils/widgets.dart';
import 'package:flutter/material.dart';

class Info {
  static message(String message,
      {GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
      BuildContext? context,
      Duration? duration,
      SnackBarBehavior snackBarBehavior = SnackBarBehavior.fixed}) {
    duration ??= const Duration(seconds: 3);
    //ThemeData theme = AppTheme.theme;

    SnackBar snackBar = SnackBar(
      duration: duration,
      content: text(
        message,
        textColor: whiteColor,
      ),
      backgroundColor: whiteColor,
      behavior: snackBarBehavior,
    );

    if (scaffoldMessengerKey != null) {
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    } else if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {}
  }

  static error(String message,
      {GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
      BuildContext? context,
      Duration? duration,
      SnackBarBehavior snackBarBehavior = SnackBarBehavior.fixed}) {
    duration ??= const Duration(seconds: 3);
    //ThemeData theme = AppTheme.theme;

    SnackBar snackBar = SnackBar(
      duration: duration,
      content: text(
        message,
        textColor: whiteColor,
      ),
      backgroundColor: redColor,
      behavior: snackBarBehavior,
    );

    if (scaffoldMessengerKey != null) {
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    } else if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {}
  }
}
