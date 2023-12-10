import 'package:flutter/material.dart';

import '../utils/constants.dart';

// ignore: must_be_immutable
class FavoriteIcon extends StatefulWidget {
  final Function ontap;
  bool isFavorite;
  FavoriteIcon({
    Key? key,
    required this.ontap,
    required this.isFavorite,
  }) : super(key: key);

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isFavorite = !widget.isFavorite;
          widget.ontap();
        });
      },
      child: !widget.isFavorite
          ? const Icon(
              Icons.favorite_border_outlined,
              color: AppColors.WHITE_COLOR,
            )
          : const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
    );
  }
}
