import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../models/onboarding_model.dart';
import '../../widgets/onboarding_widget.dart';
import 'onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  final controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Stack(
        children: [
          Obx(() {
            return SizedBox(
              height: (Get.height * .45),
              width: Get.width,
              child: SvgPicture.asset(
                screens[controller.index.value].backgroundImageUrl,
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary, BlendMode.srcIn),
              ),
            );
          }),
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: (value) {
              controller.index.value = value;
            },
            itemCount: screens.length,
            itemBuilder: (_, index) {
              return OnBoardingPageWidget(
                imageUrl: screens[index].avatarImageUrl,
                title: screens[index].title,
                description: screens[index].description,
                buttonText: screens[index].buttonText,
              );
            },
          ),
          if (controller.index.value < screens.length)
            Positioned(
              top: (Get.height / 100) * 82,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: screens
                    .map<Widget>(
                      (e) => Obx(
                        () => Container(
                          height: 10,
                          width: 10,
                          margin: const EdgeInsets.only(right: 5.0),
                          decoration: BoxDecoration(
                            color: screens[controller.index.value].id == e.id
                                ? AppColors.SECONDARY_LIGHT
                                : Theme.of(context).indicatorColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          Positioned(
            bottom: Get.height * .02,
            left: 25.0,
            right: 25.0,
            child: Obx(
              () => ButtonWidget(
                width: Get.width,
                buttonText: screens[controller.index.value].buttonText,
                bordered: true,
                onTap: controller.moveForward,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
