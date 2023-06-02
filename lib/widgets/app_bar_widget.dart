// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  final Function onTap;
  final String title;
  const AppBarCustom({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 22.0, right: 22.0, top: 10.0, bottom: 10.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => onTap(),
              child: SvgPicture.asset(AppAssets.BACK_ARROW),
            ),
            const SizedBox(width: 15.0),
            Text(title, style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 50.0);
}
