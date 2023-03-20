// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.BORDER_COLOR, width: 1.0),
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
                      colorFilter: ColorFilter.mode(
                          AppColors.GREY_COLOR, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.BLACK_COLOR,
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
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.BLACK_COLOR,
                        fontSize: 8.0,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        subtitle: Text(
          subTitle,
          style: const TextStyle(
            color: AppColors.GREY_COLOR,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Container(
          height: timeContainerHeight,
          padding: EdgeInsets.symmetric(
              horizontal: timeContainerHorizontalPadding ?? 10.0),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.SECONDARY_LIGHT,
            borderRadius: BorderRadius.circular(timeContainerRadius ?? 8.0),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.BLACK_COLOR,
                  fontSize: 8.0,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.BLACK_COLOR,
                  fontSize: 8.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
