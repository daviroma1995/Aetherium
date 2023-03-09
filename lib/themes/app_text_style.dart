/*
* File : App Theme
* Version : 1.0.0
* */

// Copyright 2021 The FlutX Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// [AppTextStyle] - gives 13 different type of styles to the text on the basis of size
import 'package:aetherium_salon/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppTextType {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,

  @Deprecated('use')
  h4,
  @Deprecated('use')
  h5,
  @Deprecated('use')
  h6,
  @Deprecated('use')
  sh1,
  @Deprecated('use')
  sh2,
  @Deprecated('use')
  button,
  @Deprecated('use')
  caption,
  @Deprecated('use')
  overline,

// Material Design 3
  @Deprecated('use')
  d1,
  @Deprecated('use')
  d2,
  @Deprecated('use')
  d3,
  @Deprecated('use')
  h1,
  @Deprecated('use')
  h2,
  @Deprecated('use')
  h3,
  @Deprecated('use')
  t1,
  @Deprecated('use')
  t2,
  @Deprecated('use')
  t3,
  @Deprecated('use')
  l1,
  @Deprecated('use')
  l2,
  @Deprecated('use')
  l3,
  @Deprecated('use')
  b1,
  @Deprecated('use')
  b2,
  @Deprecated('use')
  b3
}

class AppTextStyle {
  static Function _fontFamily = GoogleFonts.ibmPlexSans;

  static Map<int, FontWeight> _defaultFontWeight = {
    100: FontWeight.w100,
    200: FontWeight.w200,
    300: FontWeight.w300,
    400: FontWeight.w300,
    500: FontWeight.w400,
    600: FontWeight.w500,
    700: FontWeight.w600,
    800: FontWeight.w700,
    900: FontWeight.w800,
  };

  static Map<AppTextType, double> _defaultTextSize = {
    // Material Design 3

    AppTextType.displayLarge: 57,
    AppTextType.displayMedium: 45,
    AppTextType.displaySmall: 36,

    AppTextType.headlineLarge: 32,
    AppTextType.headlineMedium: 28,
    AppTextType.headlineSmall: 26,

    AppTextType.titleLarge: 22,
    AppTextType.titleMedium: 16,
    AppTextType.titleSmall: 14,

    AppTextType.labelLarge: 14,
    AppTextType.labelMedium: 12,
    AppTextType.labelSmall: 11,

    AppTextType.bodyLarge: 16,
    AppTextType.bodyMedium: 14,
    AppTextType.bodySmall: 12,

    // @Deprecated('')
    AppTextType.h4: 36,
    AppTextType.h5: 25,
    AppTextType.h6: 21,
    AppTextType.sh1: 17,
    AppTextType.sh2: 15,
    AppTextType.button: 13,
    AppTextType.caption: 12,
    AppTextType.overline: 10,

    // Material Design 3

    AppTextType.d1: 57,
    AppTextType.d2: 45,
    AppTextType.d3: 36,

    AppTextType.h1: 32,
    AppTextType.h2: 28,
    AppTextType.h3: 26,

    AppTextType.t1: 22,
    AppTextType.t2: 16,
    AppTextType.t3: 14,

    AppTextType.l1: 14,
    AppTextType.l2: 12,
    AppTextType.l3: 11,

    AppTextType.b1: 16,
    AppTextType.b2: 14,
    AppTextType.b3: 12,
  };

  static Map<AppTextType, int> _defaultTextFontWeight = {
    AppTextType.displayLarge: 500,
    AppTextType.displayMedium: 500,
    AppTextType.displaySmall: 500,

    AppTextType.headlineLarge: 500,
    AppTextType.headlineMedium: 500,
    AppTextType.headlineSmall: 500,

    AppTextType.titleLarge: 500,
    AppTextType.titleMedium: 500,
    AppTextType.titleSmall: 500,

    AppTextType.labelLarge: 600,
    AppTextType.labelMedium: 600,
    AppTextType.labelSmall: 600,

    AppTextType.bodyLarge: 500,
    AppTextType.bodyMedium: 500,
    AppTextType.bodySmall: 500,
    //
    // // Material Design 2 (Old)
    AppTextType.h4: 500,
    AppTextType.h5: 500,
    AppTextType.h6: 500,
    AppTextType.sh1: 500,
    AppTextType.sh2: 500,
    AppTextType.button: 500,
    AppTextType.caption: 500,
    AppTextType.overline: 500,

    //Material Design 3

    AppTextType.d1: 500,
    AppTextType.d2: 500,
    AppTextType.d3: 500,

    AppTextType.h1: 500,
    AppTextType.h2: 500,
    AppTextType.h3: 500,

    AppTextType.t1: 500,
    AppTextType.t2: 500,
    AppTextType.t3: 500,

    AppTextType.l1: 600,
    AppTextType.l2: 600,
    AppTextType.l3: 600,

    AppTextType.b1: 500,
    AppTextType.b2: 500,
    AppTextType.b3: 500,
  };

  static Map<AppTextType, double> _defaultLetterSpacing = {
    AppTextType.displayLarge: -0.25,
    AppTextType.displayMedium: 0,
    AppTextType.displaySmall: 0,

    AppTextType.headlineLarge: -0.2,
    AppTextType.headlineMedium: -0.15,
    AppTextType.headlineSmall: 0,

    AppTextType.titleLarge: 0,
    AppTextType.titleMedium: 0.1,
    AppTextType.titleSmall: 0.1,

    AppTextType.labelLarge: 0.1,
    AppTextType.labelMedium: 0.5,
    AppTextType.labelSmall: 0.5,

    AppTextType.bodyLarge: 0.5,
    AppTextType.bodyMedium: 0.25,
    AppTextType.bodySmall: 0.4,
    //
    // Deprecated
    AppTextType.h4: 0,
    AppTextType.h5: 0,
    AppTextType.h6: 0,
    AppTextType.sh1: 0.15,
    AppTextType.sh2: 0.15,
    AppTextType.button: 0.15,
    AppTextType.caption: 0.15,
    AppTextType.overline: 0.15,

    //Material Design 3
    AppTextType.d1: -0.25,
    AppTextType.d2: 0,
    AppTextType.d3: 0,

    AppTextType.h1: -0.2,
    AppTextType.h2: -0.15,
    AppTextType.h3: 0,

    AppTextType.t1: 0,
    AppTextType.t2: 0.1,
    AppTextType.t3: 0.1,

    AppTextType.l1: 0.1,
    AppTextType.l2: 0.5,
    AppTextType.l3: 0.5,

    AppTextType.b1: 0.5,
    AppTextType.b2: 0.25,
    AppTextType.b3: 0.4,
  };

  @Deprecated('message')
  static TextStyle getStyle(
      {TextStyle? textStyle,
      int? fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double letterSpacing = 0.15,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    double? finalFontSize =
        fontSize ?? (textStyle == null ? 40 : textStyle.fontSize);

    Color? finalColor;
    if (color == null) {
      Color themeColor =
          AppTheme.getThemeFromThemeMode().colorScheme.onBackground;
      finalColor = xMuted
          ? themeColor.withAlpha(160)
          : (muted ? themeColor.withAlpha(200) : themeColor);
    } else {
      finalColor = xMuted
          ? color.withAlpha(160)
          : (muted ? color.withAlpha(200) : color);
    }

    return _fontFamily(
        fontSize: finalFontSize,
        fontWeight: _defaultFontWeight[fontWeight] ?? FontWeight.w400,
        letterSpacing: letterSpacing,
        color: finalColor,
        decoration: decoration,
        height: height,
        wordSpacing: wordSpacing);
  }

  @Deprecated('message')
  static TextStyle h4(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.h4],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.h4] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h5(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.h5],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.h5] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h6(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.h6],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.h6] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle sh1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.sh1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.sh1] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle sh2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.sh2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.sh2] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle button(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.button],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.button] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle caption(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing = 0,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.caption],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.caption] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle overline(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.overline],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.overline] ??
            0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  // Material Design 3
  @Deprecated('message')
  static TextStyle d1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.d1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.d1] ?? -0.2,
        fontWeight: _defaultTextFontWeight[AppTextType.d1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle d2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.d2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.d2] ?? -0.2,
        fontWeight: _defaultTextFontWeight[AppTextType.d2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle d3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.d3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.d3] ?? -0.2,
        fontWeight: _defaultTextFontWeight[AppTextType.d3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.h1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.h1] ?? -0.2,
        fontWeight: _defaultTextFontWeight[AppTextType.h1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.h2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.h2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.h2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.h3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.h3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.h3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle t1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.t1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.t1] ?? -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.t1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle t2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.t2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.t2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.t2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle t3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.t3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.t3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.t3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle l1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.l1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.l1] ?? -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.l1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle l2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.l2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.l2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.l2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle l3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.l3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.l3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.l3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle b1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.b1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.b1] ?? 0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.b1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle b2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.b2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.b2] ?? 0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.b2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle b3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.b3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[AppTextType.b3] ?? 0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.b3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  // Material Design 3
  static TextStyle displayLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.displayLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.displayLarge] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[AppTextType.displayLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle displayMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.displayMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.displayMedium] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[AppTextType.displayMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle displaySmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.displaySmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.displaySmall] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[AppTextType.displaySmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle headlineLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.headlineLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.headlineLarge] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[AppTextType.headlineLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle headlineMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.headlineMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.headlineMedium] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.headlineMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle headlineSmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.headlineSmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.headlineSmall] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.headlineSmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle titleLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.titleLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.titleLarge] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.titleLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle titleMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.titleMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.titleMedium] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.titleMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle titleSmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.titleSmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.titleSmall] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.titleSmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle labelLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.labelLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.labelLarge] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.labelLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle labelMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.labelMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.labelMedium] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.labelMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle labelSmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.labelSmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.labelSmall] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.labelSmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle bodyLarge(
      {TextStyle? textStyle,
      int? fontWeight,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.bodyLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.bodyLarge] ??
            0.15,
        fontWeight:
            fontWeight ?? _defaultTextFontWeight[AppTextType.bodyLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle bodyMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.bodyMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.bodyMedium] ??
            0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.bodyMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle bodySmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[AppTextType.bodySmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[AppTextType.bodySmall] ??
            0.15,
        fontWeight: _defaultTextFontWeight[AppTextType.bodySmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static void changeFontFamily(Function fontFamily) {
    AppTextStyle._fontFamily = fontFamily;
  }

  static void changeDefaultFontWeight(Map<int, FontWeight> defaultFontWeight) {
    AppTextStyle._defaultFontWeight = defaultFontWeight;
  }

  static void changeDefaultTextSize(Map<AppTextType, double> defaultTextSize) {
    AppTextStyle._defaultTextSize = defaultTextSize;
  }

  static Map<AppTextType, double> get defaultTextSize => _defaultTextSize;

  static Map<AppTextType, double> get defaultLetterSpacing =>
      _defaultLetterSpacing;

  static Map<AppTextType, int> get defaultTextFontWeight =>
      _defaultTextFontWeight;

  static Map<int, FontWeight> get defaultFontWeight => _defaultFontWeight;

  //-------------------Reset Font Styles---------------------------------
  static resetFontStyles() {
    _fontFamily = GoogleFonts.ibmPlexSans;

    _defaultFontWeight = {
      100: FontWeight.w100,
      200: FontWeight.w200,
      300: FontWeight.w300,
      400: FontWeight.w300,
      500: FontWeight.w400,
      600: FontWeight.w500,
      700: FontWeight.w600,
      800: FontWeight.w700,
      900: FontWeight.w800,
    };

    _defaultTextSize = {
      AppTextType.displayLarge: 57,
      AppTextType.displayMedium: 45,
      AppTextType.displaySmall: 36,

      AppTextType.headlineLarge: 32,
      AppTextType.headlineMedium: 28,
      AppTextType.headlineSmall: 26,

      AppTextType.titleLarge: 22,
      AppTextType.titleMedium: 16,
      AppTextType.titleSmall: 14,

      AppTextType.labelLarge: 14,
      AppTextType.labelMedium: 12,
      AppTextType.labelSmall: 11,

      AppTextType.bodyLarge: 16,
      AppTextType.bodyMedium: 14,
      AppTextType.bodySmall: 12,

      AppTextType.h4: 36,
      AppTextType.h5: 25,
      AppTextType.h6: 21,
      AppTextType.sh1: 17,
      AppTextType.sh2: 15,
      AppTextType.button: 13,
      AppTextType.caption: 12,
      AppTextType.overline: 10,

      // Material Design 3

      AppTextType.d1: 57,
      AppTextType.d2: 45,
      AppTextType.d3: 36,

      AppTextType.h1: 32,
      AppTextType.h2: 28,
      AppTextType.h3: 26,

      AppTextType.t1: 22,
      AppTextType.t2: 16,
      AppTextType.t3: 14,

      AppTextType.l1: 14,
      AppTextType.l2: 12,
      AppTextType.l3: 11,

      AppTextType.b1: 16,
      AppTextType.b2: 14,
      AppTextType.b3: 12,
    };

    _defaultTextFontWeight = {
      AppTextType.displayLarge: 500,
      AppTextType.displayMedium: 500,
      AppTextType.displaySmall: 500,

      AppTextType.headlineLarge: 500,
      AppTextType.headlineMedium: 500,
      AppTextType.headlineSmall: 500,

      AppTextType.titleLarge: 500,
      AppTextType.titleMedium: 500,
      AppTextType.titleSmall: 500,

      AppTextType.labelLarge: 600,
      AppTextType.labelMedium: 600,
      AppTextType.labelSmall: 600,

      AppTextType.bodyLarge: 500,
      AppTextType.bodyMedium: 500,
      AppTextType.bodySmall: 500,

      // Material Design 2 (Old)
      AppTextType.h4: 500,
      AppTextType.h5: 500,
      AppTextType.h6: 500,
      AppTextType.sh1: 500,
      AppTextType.sh2: 500,
      AppTextType.button: 500,
      AppTextType.caption: 500,
      AppTextType.overline: 500,

      //Material Design 3

      AppTextType.d1: 500,
      AppTextType.d2: 500,
      AppTextType.d3: 500,

      AppTextType.h1: 500,
      AppTextType.h2: 500,
      AppTextType.h3: 500,

      AppTextType.t1: 500,
      AppTextType.t2: 500,
      AppTextType.t3: 500,

      AppTextType.l1: 600,
      AppTextType.l2: 600,
      AppTextType.l3: 600,

      AppTextType.b1: 500,
      AppTextType.b2: 500,
      AppTextType.b3: 500,
    };

    _defaultLetterSpacing = {
      AppTextType.displayLarge: -0.25,
      AppTextType.displayMedium: 0,
      AppTextType.displaySmall: 0,

      AppTextType.headlineLarge: -0.2,
      AppTextType.headlineMedium: -0.15,
      AppTextType.headlineSmall: 0,

      AppTextType.titleLarge: 0,
      AppTextType.titleMedium: 0.1,
      AppTextType.titleSmall: 0.1,

      AppTextType.labelLarge: 0.1,
      AppTextType.labelMedium: 0.5,
      AppTextType.labelSmall: 0.5,

      AppTextType.bodyLarge: 0.5,
      AppTextType.bodyMedium: 0.25,
      AppTextType.bodySmall: 0.4,

      //@deprecated
      AppTextType.h4: 0,
      AppTextType.h5: 0,
      AppTextType.h6: 0,
      AppTextType.sh1: 0.15,
      AppTextType.sh2: 0.15,
      AppTextType.button: 0.15,
      AppTextType.caption: 0.15,
      AppTextType.overline: 0.15,

      //Material Design 3
      AppTextType.d1: -0.25,
      AppTextType.d2: 0,
      AppTextType.d3: 0,

      AppTextType.h1: -0.2,
      AppTextType.h2: -0.15,
      AppTextType.h3: 0,

      AppTextType.t1: 0,
      AppTextType.t2: 0.1,
      AppTextType.t3: 0.1,

      AppTextType.l1: 0.1,
      AppTextType.l2: 0.5,
      AppTextType.l3: 0.5,

      AppTextType.b1: 0.5,
      AppTextType.b2: 0.25,
      AppTextType.b3: 0.4,
    };
  }
}
