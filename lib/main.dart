import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: context.isDarkMode
            ? AppColors.BACKGROUND_COLOR
            : AppColors.BACKGROUND_DARK,
        statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aetherium App',
        theme: theme,
        darkTheme: darkTheme,
        home: SplashScreen(),
      ),
    );
  }
}
