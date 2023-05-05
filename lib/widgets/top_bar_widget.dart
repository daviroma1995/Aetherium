import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
  final Widget firstItem;
  final Widget secondItem;
  final double space;
  const TopBar(
      {super.key,
      required this.firstItem,
      required this.secondItem,
      this.space = 10.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBanner(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 27.0),
          child: Row(
            children: [
              firstItem,
              SizedBox(width: space),
              secondItem,
            ],
          ),
        ),
      ],
    );
  }
}

class TopBanner extends StatelessWidget {
  const TopBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: Get.height * .22,
          width: Get.width,
          child: SvgPicture.asset(
            AppAssets.LOGIN_TOP_BAR,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary, BlendMode.srcIn),
          ),
        ),
        Positioned(
          top: (Get.height / 100) * 10,
          left: 0,
          right: 0,
          child: SvgPicture.asset(
            AppAssets.TOP_BAR_LOGO,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSecondary, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}
