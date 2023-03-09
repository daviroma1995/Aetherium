import 'package:aetherium_salon/auth/forgot_pwd_screen.dart';
import 'package:aetherium_salon/auth/sign_in_screen.dart';
import 'package:aetherium_salon/screens/about_us_screen.dart';
import 'package:aetherium_salon/screens/guidelines_screen.dart';
import 'package:aetherium_salon/screens/main/channel_app_screen.dart';
import 'package:aetherium_salon/screens/splash_screen.dart';
import 'package:aetherium_salon/screens/treatments_screen.dart';

var appRoutes = {
  '/home': (context) => const SplashScreen(),
  '/sign_in': (context) => const SignInScreen(),
  '/forgot_password': (context) => const ForgotPasswordScreen(),
  '/channel': (context) => const ChannelScreen(),
  '/about_us': (context) => const AboutScreen(),
  '/treatments': (context) => const TreatmentsScreen(),
  '/guidelines': (context) => const GuidelinesScreen(),
};
