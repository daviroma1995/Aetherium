import 'package:aetherium_salon/themes/theme_type.dart';
import 'package:aetherium_salon/utils/colors.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

class NavigationTheme {
  Color? backgroundColor,
      selectedItemIconColor,
      selectedItemTextColor,
      selectedItemColor,
      selectedOverlayColor,
      unselectedItemIconColor,
      unselectedItemTextColor,
      unselectedItemColor;

  static NavigationTheme getNavigationTheme([ThemeType? themeType]) {
    NavigationTheme navigationBarTheme = NavigationTheme();
    themeType = themeType ?? AppTheme.defaultThemeType;
    if (themeType == ThemeType.light) {
      navigationBarTheme.backgroundColor = Colors.white;
      navigationBarTheme.selectedItemColor = primaryColor;
      navigationBarTheme.unselectedItemColor = const Color(0xff495057);
      navigationBarTheme.selectedOverlayColor = const Color.fromARGB(255, 223, 164, 93);
    } else {
      navigationBarTheme.backgroundColor = const Color(0xff37404a);
      navigationBarTheme.selectedItemColor = const Color(0xff37404a);
      navigationBarTheme.unselectedItemColor = const Color(0xffd1d1d1);
      navigationBarTheme.selectedOverlayColor = const Color(0xffffffff);
    }
    return navigationBarTheme;
  }
}
