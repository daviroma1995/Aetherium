import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/utils/shared_preferences.dart';
import 'package:atherium_saloon_app/utils/theme.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(LoginController()));
  await LocalData.loadData();

  // var callable = FirebaseFunctions.instance.httpsCallableFromUri(Uri.parse(
  //     'https://us-central1-aetherium-salon.cloudfunctions.net/timeslots'));
  // var res = await callable.call({
  //   "date": "05/24/2023",
  //   "treatments": [
  //     {
  //       "id": "duIgxkxkS0JuV7O025Ou",
  //       "duration": 60,
  //       "is_employee_required": true,
  //       "name": "tradizionale",
  //       "price": 20,
  //       "treatment_category_id": "LtTOqTyCqv9tznPnPlIY",
  //       "room_id_list": ["dVpxu2V9avzFT63SFClL"]
  //     }
  //   ]
  // });
  // print(res.data);
  // final HttpsCallable timeslotsCallable = FirebaseFunctions.instance
  //     .httpsCallableFromUri(Uri.parse(
  //         'https://www.postman.com/jordyt1707/workspace/firebase-cloud-functions'));

  // void callTimeslotsFunction() async {
  //   try {
  //     final response = await timeslotsCallable(<String, dynamic>{
  //       "date": "05/24/2023",
  //       "treatments": [
  //         {
  //           "id": "duIgxkxkS0JuV7O025Ou",
  //           "duration": 60,
  //           "is_employee_required": true,
  //           "name": "tradizionale",
  //           "price": 20,
  //           "treatment_category_id": "LtTOqTyCqv9tznPnPlIY",
  //           "room_id_list": ["dVpxu2V9avzFT63SFClL"]
  //         }
  //       ]
  //     });

  //     // Handle the response from the function
  //     final data = response.data;

  //     print('Timeslots function executed successfully.');
  //     print('Response: $data');
  //   } catch (e) {
  //     print('Error calling timeslots function: $e');
  //   }
  // }

  // callTimeslotsFunction();
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
