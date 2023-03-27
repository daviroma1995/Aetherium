import 'dart:async';

import 'package:atherium_saloon_app/screens/splash_screen/splash_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  final controller = Get.put(SplashScreenController());
  SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                AppAssets.SPLASH_TOP_IMAGE,
                width: size.width * .75,
              ),
            ),
            Image.asset(
              AppAssets.SPLASH_LOGO_IMAGE,
              width: 230,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(AppAssets.SPLASH_BOTTOM_IMAGE,
                  width: size.width * .45),
            ),
          ],
        ),
      ),
    );
  }
}
