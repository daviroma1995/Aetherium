import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isUnderLined;
  const CustomTitle({
    super.key,
    required this.title,
    this.subTitle = 'See All',
    this.isUnderLined = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              bottom: 5, // Space between underline and text
            ),
            decoration: BoxDecoration(
              border: isUnderLined
                  ? Border(
                      bottom: BorderSide(
                        color: AppColors.GREY_COLOR,
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
                color: AppColors.GREY_COLOR,
              ),
            ),
          )
        ],
      ),
    );
  }
}
