import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class CustomListTIle extends StatelessWidget {
  final int index;
  final String title;
  final String imageUrl;
  final Function onTap;
  const CustomListTIle({
    Key? key,
    required this.index,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: isDark
              ? const Border()
              : Border.all(color: AppColors.BORDER_COLOR),
          borderRadius: BorderRadius.circular(8.0),
          color: isDark ? AppColors.PRIMARY_DARK : AppColors.WHITE_COLOR,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: isDark
                        ? AppColors.SECONDARY_LIGHT
                        : AppColors.SECONDARY_COLOR,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12.0),
                    child: SvgPicture.asset(
                      imageUrl,
                      colorFilter: ColorFilter.mode(
                          isDark
                              ? AppColors.BACKGROUND_DARK
                              : AppColors.WHITE_COLOR,
                          BlendMode.srcIn),
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 16.0, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SvgPicture.asset(
              AppAssets.RIGHT_ARROW,
              colorFilter:
                  const ColorFilter.mode(AppColors.GREY_COLOR, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
