import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class CustomEventCardWidget extends StatelessWidget {
  final int index;
  final String iamgeUrl;
  final String title;
  final String subTitle;
  final String time;
  final bool isFavorite;
  final Function onIconTap;
  const CustomEventCardWidget({
    Key? key,
    required this.index,
    required this.iamgeUrl,
    required this.title,
    required this.subTitle,
    required this.time,
    required this.isFavorite,
    required this.onIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 190.0,
      width: 190.0,
      child: Stack(
        children: [
          Positioned(
            bottom: 2,
            child: Container(
              height: 92.0,
              width: 190.0,
              decoration: BoxDecoration(
                color: isDark ? AppColors.PRIMARY_DARK : AppColors.WHITE_COLOR,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
                border: isDark
                    ? const Border()
                    : Border.all(
                        width: 1.0,
                        color: AppColors.BORDER_COLOR,
                      ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      subTitle,
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.CALANDER_ICON,
                          colorFilter: isDark
                              ? ColorFilter.mode(
                                  AppColors.SECONDARY_LIGHT, BlendMode.srcIn)
                              : ColorFilter.mode(
                                  AppColors.PRIMARY_COLOR, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.SECONDARY_LIGHT
                                : AppColors.PRIMARY_COLOR,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 98.0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                child: CachedNetworkImage(
                  width: 190.0,
                  height: 108.0,
                  fit: BoxFit.cover,
                  imageUrl: iamgeUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Positioned(
            top: 9.0,
            right: 10.0,
            child: GestureDetector(
              onTap: () => onIconTap(index),
              child: !isFavorite
                  ? const Icon(
                      Icons.favorite_border_outlined,
                      color: AppColors.WHITE_COLOR,
                    )
                  : const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
