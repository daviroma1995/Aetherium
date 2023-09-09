// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomLabelWidget extends StatelessWidget {
  final String label;
  final TextStyle? style;
  const CustomLabelWidget({
    Key? key,
    required this.label,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: style ??
              Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color:
                        isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
                  ),
        ).tr(),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
