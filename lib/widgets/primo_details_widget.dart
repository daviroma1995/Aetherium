// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../utils/constants.dart';

class PrimoDetailsWidget extends StatelessWidget {
  final double percent;
  final Color progressColor;
  final String primoTitle;
  final String? pointsGained;
  final String? totalPoints;
  final String date;
  final String imageUrl;
  final VoidCallback? onPressed;
  const PrimoDetailsWidget({
    Key? key,
    required this.percent,
    required this.progressColor,
    required this.primoTitle,
    this.pointsGained,
    this.totalPoints,
    required this.date,
    required this.imageUrl,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircularPercentIndicator(
              radius: 27.0,
              lineWidth: 4.8,
              percent: percent,
              backgroundColor:
                  isDark ? AppColors.BACKGROUND_DARK : AppColors.BORDER_COLOR,
              center: Container(
                padding: const EdgeInsets.all(3.0),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 3.0),
                child:
                    CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
              ),
              progressColor: progressColor,
            ),
            SizedBox(width: size.width * .034),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  primoTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 16.0, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6.0),
                Text(
                  '${tr('By')} $date',
                  style: const TextStyle(
                    color: AppColors.GREY_COLOR,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            pointsGained == null
                ? MaterialButton(
                    minWidth: 32.0,
                    padding: const EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    onPressed: onPressed!,
                    child: Container(
                      alignment: Alignment.center,
                      height: 35.0,
                      width: 35.0,
                      child: SvgPicture.asset(
                        AppAssets.QRCODE_ICON,
                        colorFilter: ColorFilter.mode(
                            isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.BLACK_COLOR,
                            BlendMode.srcIn),
                      ),
                    ),
                  )
                : Text(
                    '$pointsGained of $totalPoints',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 16.0, fontWeight: FontWeight.w700),
                  ),
            const SizedBox(height: 6.0),
            pointsGained == null
                ? const SizedBox()
                : const Text(
                    'Points',
                    style: TextStyle(
                      color: AppColors.GREY_COLOR,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
