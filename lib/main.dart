import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:atherium_saloon_app/screens/splash_screen/splash_screen.dart';
import 'package:atherium_saloon_app/utils/bindings.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/utils/shared_preferences.dart';
import 'package:atherium_saloon_app/utils/theme.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.deviceCheck,
  );
  await LocalData.loadData();

  runApp(Phoenix(child: const MyApp()));
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
        initialBinding: AppBindings(),
        debugShowCheckedModeBanner: false,
        title: 'Aetherium App',
        theme: theme,
        darkTheme: darkTheme,
        home: SplashScreen(),
      ),
    );
  }
}
