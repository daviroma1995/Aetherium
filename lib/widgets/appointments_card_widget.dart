// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        contentPadding: EdgeInsets.only(
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
            border: Border.all(
              width: 1.3,
              color: AppColors.BORDER_COLOR,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          AppColors.GREY_COLOR, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 15.0,
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
        subtitle: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            subTitle,
            maxLines: 1,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: AppColors.GREY_COLOR,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
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
