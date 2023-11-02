import 'package:flutter/material.dart';

class TextRowWidget extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final TextStyle style;
  const TextRowWidget({
    Key? key,
    required this.textOne,
    required this.textTwo,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(textOne, style: style)),
        Expanded(
          child: Text(textTwo, style: style),
        ),
      ],
    );
  }
}
