import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomLabelWidget extends StatelessWidget {
  final String label;
  const CustomLabelWidget({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isDark
                      ? AppColors.WHITE_COLOR
                      : AppColors.SECONDARY_COLOR,
                )),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
