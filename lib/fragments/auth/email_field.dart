import 'package:aetherium_salon/validator/string_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:aetherium_salon/utils/colors.dart' as colors;
import 'package:aetherium_salon/utils/strings.dart' as strings;

class EmailField extends StatelessWidget {
  const EmailField(
      {Key? key,
      required TextEditingController controller,
      required this.outlineInputBorder,
      required this.errorOutlineInputBorder})
      : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder errorOutlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            FeatherIcons.mail,
            size: 20,
            color: colors.fontColor,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          errorBorder: errorOutlineInputBorder,
          focusedErrorBorder: errorOutlineInputBorder,
          hintText: strings.usernamePlaceholder,
          hintStyle: const TextStyle(color: colors.fontColor)),
      validator: StringUtils.validateEmail,
    );
  }
}
