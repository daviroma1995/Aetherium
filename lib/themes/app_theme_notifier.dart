/*
* File : App Theme Notifier (Listener)
* Version : 1.0.0
* */

// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [AppThemeNotifier] - notifies the app by giving the theme to the app

import 'dart:developer';

import 'package:aetherium_salon/themes/theme_type.dart';
import 'package:flutter/material.dart';
// import 'custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

class AppThemeNotifier extends ChangeNotifier {
  init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    int appThemeMode =
        sharedPreferences.getInt("fx_app_theme_mode") ?? ThemeType.light.index;
    changeAppThemeMode(ThemeType.values[appThemeMode]);

    // int fxCustomThemeMode = sharedPreferences.getInt("fx_custom_theme_mode")??AppThemeType.light.index;
    // changeCustomThemeMode(FxCustomThemeType.values[fxCustomThemeMode]);

    notifyListeners();
  }

  changeAppThemeMode(ThemeType? themeType) async {
    AppTheme.defaultThemeType = themeType!;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt("fx_app_theme_mode", themeType.index);

    log(AppTheme.getThemeFromThemeMode().toString());
    notifyListeners();
  }

  // changeCustomThemeMode(FxCustomThemeType? themeType) async {
  //   FxCustomTheme.defaultThemeType = themeType!;
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.setInt("fx_custom_theme_mode", themeType.index);
  //
  //   notifyListeners();
  // }

}
