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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(
                AppAssets.SPLASH_TOP,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
                width: Get.width * .7,
              ),
            ),
            Center(
                child: Center(
              child: SvgPicture.asset((AppAssets.SPLASH_TEXT),
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSecondary,
                      BlendMode.srcIn)),
            )),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                AppAssets.SPLASH_BOTTOM,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
                width: Get.width * .4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
