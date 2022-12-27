import 'dart:async';
import 'dart:developer';

import 'package:aetherium_salon/auth/sign_in_screen.dart';
import 'package:aetherium_salon/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:aetherium_salon/screens/walk_through_screen.dart';
import 'package:aetherium_salon/utils/my_shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SharedPrefs.getSkipWalkthrough().then((value) => setState(() {
          log('skipWalkthrough:  $value');
          init(value);
        }));
    super.initState();
  }

  void init(bool skipWalkthrough) {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => skipWalkthrough
                  ? const SignInScreen()
                  : const WalkThroughScreen()),
          (route) => false,
        );
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Image.asset(splashLogo, width: 100, height: 100, fit: BoxFit.cover),
      ),
    );
  }
}
