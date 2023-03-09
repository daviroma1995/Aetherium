import 'package:aetherium_salon/utils/colors.dart';
import 'package:aetherium_salon/utils/spacing.dart';
import 'package:aetherium_salon/widgets/container/container.dart';
import 'package:aetherium_salon/widgets/text/text.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key, required String title, String? subtitle, Color? color})
      : _title = title,
        _subtitle = subtitle,
        _color = color,
        super(key: key);

  final String _title;
  final String? _subtitle;
  final Color? _color;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      color: _color ?? primaryColor,
      padding: Spacing.all(24),
      margin: Spacing.horizontal(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.bodyLarge(_title, color: Colors.white, fontWeight: 600, letterSpacing: 0),
          Spacing.height(8),
          AppText.bodySmall(_subtitle ?? "",
              color: Theme.of(context).colorScheme.onBackground.withAlpha(100), fontWeight: 500, letterSpacing: -0.2),
        ],
      ),
    );
  }
}
