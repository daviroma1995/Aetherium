import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class CustomAppointmentCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String time;
  final String date;
  const CustomAppointmentCardWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.time,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(right: 11.0),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            height: 75.0,
            width: 252.0,
            decoration: BoxDecoration(
              border: isDark
                  ? const Border()
                  : Border.all(color: AppColors.BORDER_COLOR),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              color: isDark ? AppColors.BACKGROUND_DARK : AppColors.WHITE_COLOR,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.3,
                        color: AppColors.BORDER_COLOR,
                      ),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(imageUrl),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 16.0,
                                  color: isDark
                                      ? AppColors.WHITE_COLOR
                                      : AppColors.BLACK_COLOR),
                        ),
                        const SizedBox(height: 6.0),
                        FittedBox(
                          child: Text(
                            subTitle,
                            maxLines: 1,
                            style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: AppColors.GREY_COLOR,
                              letterSpacing: 0.75,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            child: Container(
              height: 27.0,
              width: 252.0,
              decoration: const BoxDecoration(
                color: AppColors.SECONDARY_LIGHT,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 22.0),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.CLOCK_ICON),
                      const SizedBox(width: 8.0),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 16.0),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.CALANDER_ICON),
                      const SizedBox(width: 8.0),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: AppColors.PRIMARY_COLOR,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
