import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:aetherium_salon/components/my_scroll_behaviour.dart';
import 'package:aetherium_salon/screens/splash_screen.dart';
import 'package:aetherium_salon/utils/colors.dart';
import 'package:aetherium_salon/utils/constant.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Text('error');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            scrollBehavior: MyScrollBehavior(),
            debugShowCheckedModeBanner: false,
            title: appName,
            theme: ThemeData.light().copyWith(
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
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: whiteColor,
                selectedItemColor: bottomSelectedColor,
                unselectedItemColor: bottomUnselectedColor,
              ),
            ),
            themeMode: ThemeMode.light,
            home: const SplashScreen(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Text('loading');
      },
    );
  }
}
