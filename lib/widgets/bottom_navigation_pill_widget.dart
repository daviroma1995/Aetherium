import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class BottomNavigationPill extends StatelessWidget {
  final int index;
  final String iconUrl;
  final String label;
  final bool isCurrent;
  final Function onTap;
  const BottomNavigationPill({
    Key? key,
    required this.index,
    required this.iconUrl,
    required this.label,
    required this.isCurrent,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 38.0,
        margin: isCurrent ? const EdgeInsets.symmetric(vertical: 10.0) : null,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              height: 25.0,
              width: 23.0,
              child: SvgPicture.asset(iconUrl,
                  colorFilter: ColorFilter.mode(
                      isCurrent
                          ? AppColors.SECONDARY_LIGHT
                          : AppColors.WHITE_COLOR,
                      BlendMode.srcIn)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: isCurrent
                        ? AppColors.SECONDARY_LIGHT
                        : AppColors.WHITE_COLOR,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
