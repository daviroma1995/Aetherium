import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class OnBoardingPageWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String buttonText;
  const OnBoardingPageWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          Positioned(
            top: Get.height * .10,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              imageUrl,
              fit: BoxFit.contain,
              height: Get.height * .28,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * .30),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: AppColors.BACKGROUND_COLOR,
                  ),
                ).tr(),
                const SizedBox(height: 5.0),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.GREY_COLOR,
                    fontSize: 16.0,
                  ),
                ).tr(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
