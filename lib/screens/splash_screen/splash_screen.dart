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
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(AppAssets.SPLASH_TOP),
            ),
            Center(
                child: Center(
              child: SvgPicture.asset((AppAssets.SPLASH_TEXT)),
            )),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(AppAssets.SPLASH_BOTTOM),
            ),
          ],
        ),
      ),
    );
  }
}
