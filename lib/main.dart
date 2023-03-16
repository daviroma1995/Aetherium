import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'screens/bottom_navigation_scren/bottom_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppLanguages.APP_NAME,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.BACKGROUND_COLOR,
        fontFamily: 'Lato',
      ),
      home: SplashScreen(),
    );
  }
}
