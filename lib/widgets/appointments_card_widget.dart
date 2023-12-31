// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class AppointmentsCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  final String? status;
  final Color color;
  final String date;
  final String time;
  final double? timeContainerHeight;
  final double? timeContainerRadius;
  final double? timeContainerHorizontalPadding;
  const AppointmentsCardWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    this.status,
    required this.color,
    required this.date,
    required this.time,
    this.timeContainerHeight,
    this.timeContainerRadius,
    this.timeContainerHorizontalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: ListTile(
        contentPadding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        tileColor: isDark ? AppColors.PRIMARY_DARK : AppColors.WHITE_COLOR,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: isDark ? AppColors.PRIMARY_DARK : AppColors.BORDER_COLOR,
              width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        leading: Container(
          alignment: Alignment.center,
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: isDark ? AppColors.BACKGROUND_DARK : AppColors.PRIMARY_COLOR,
          ),
          child: SvgPicture.asset(
            AppAssets.CALANDER_ICON,
            height: 24.0,
            fit: BoxFit.contain,
            colorFilter:
                const ColorFilter.mode(AppColors.WHITE_COLOR, BlendMode.srcIn),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            status != null
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 7.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text(
                      status!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.BLACK_COLOR,
                        fontSize: 6.0,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        subtitle: Text(
          subTitle,
          maxLines: 1,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: AppColors.GREY_COLOR,
            fontSize: 8.0,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Container(
          height: timeContainerHeight,
          padding: EdgeInsets.symmetric(
              horizontal: timeContainerHorizontalPadding ?? 10.0),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                isDark ? AppColors.BACKGROUND_DARK : AppColors.SECONDARY_LIGHT,
            borderRadius: BorderRadius.circular(timeContainerRadius ?? 8.0),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 8.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 8.0,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
