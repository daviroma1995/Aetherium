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
        margin: isCurrent ? const EdgeInsets.symmetric(vertical: 10.0) : null,
        padding: isCurrent
            ? const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0)
            : null,
        decoration: BoxDecoration(
          color: isCurrent ? AppColors.SECONDARY_LIGHT : Colors.transparent,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              height: isCurrent ? 20.0 : 25.0,
              width: isCurrent ? 20.0 : 23.0,
              child: SvgPicture.asset(
                iconUrl,
                colorFilter: isCurrent
                    ? ColorFilter.mode(Theme.of(context).colorScheme.onSurface,
                        BlendMode.srcIn)
                    : ColorFilter.mode(Theme.of(context).colorScheme.onPrimary,
                        BlendMode.srcIn),
              ),
            ),
            isCurrent
                ? Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: FittedBox(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
