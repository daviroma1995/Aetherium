import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../utils/constants.dart';

class Primo_Details_Widget extends StatelessWidget {
  final double percent;
  final Color progressColor;
  final String primoTitle;
  final String pointsGained;
  final String totalPoints;
  final String date;
  final String imageUrl;
  const Primo_Details_Widget({
    Key? key,
    required this.percent,
    required this.progressColor,
    required this.primoTitle,
    required this.pointsGained,
    required this.totalPoints,
    required this.date,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularPercentIndicator(
          radius: 27.0,
          lineWidth: 4.8,
          percent: percent,
          backgroundColor: AppColors.BORDER_COLOR,
          center: SvgPicture.asset(imageUrl),
          progressColor: progressColor,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              primoTitle,
              style: const TextStyle(
                color: AppColors.BLACK_COLOR,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              'By $date',
              style: const TextStyle(
                color: AppColors.GREY_COLOR,
                fontSize: 10.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$pointsGained of $totalPoints',
              style: const TextStyle(
                color: AppColors.BLACK_COLOR,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6.0),
            const Text(
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
