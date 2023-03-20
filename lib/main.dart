import 'package:atherium_saloon_app/screens/settings_screen/settings_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'screens/contacts_screen/contacts_screen.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'screens/bottom_navigation_scren/bottom_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: context.isDarkMode
            ? AppColors.BACKGROUND_COLOR
            : AppColors.BACKGROUND_DARK,
        statusBarIconBrightness:
            context.isDarkMode ? Brightness.dark : Brightness.light,
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppLanguages.APP_NAME,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.BACKGROUND_COLOR,
        unselectedWidgetColor: AppColors.GREY_COLOR,
        fontFamily: 'Lato',
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: AppColors.BACKGROUND_DARK,
        unselectedWidgetColor: AppColors.GREY_COLOR,
      ),
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}
