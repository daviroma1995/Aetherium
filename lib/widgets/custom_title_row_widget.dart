// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isUnderLined;
  final TextStyle? style;
  final Color borderColor;
  final Function? onTap;
  final Color? subtitleColor;
  const CustomTitle({
    Key? key,
    required this.title,
    this.subTitle = 'see_all',
    this.isUnderLined = true,
    this.style,
    this.borderColor = AppColors.GREY_COLOR,
    this.onTap,
    this.subtitleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: style ??
                const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
          ).tr(),
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap!();
              } else {
                () {};
              }
            },
            child: Container(
              padding: const EdgeInsets.only(
                bottom: 5, // Space between underline and text
              ),
              decoration: BoxDecoration(
                border: isUnderLined
                    ? Border(
                        bottom: BorderSide(
                          color: borderColor,
                          width: 1.0, // Underline thickness
                        ),
                      )
                    : null,
              ),
              child: Text(
                subTitle,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .75,
                  color: subtitleColor ?? borderColor,
                ),
              ).tr(),
            ),
          )
        ],
      ),
    );
  }
}
