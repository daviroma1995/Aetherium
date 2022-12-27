import 'package:aetherium_salon/controller/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:aetherium_salon/utils/colors.dart' as colors;
import 'package:aetherium_salon/utils/strings.dart' as strings;

class EmailField extends StatelessWidget {
  const EmailField(
      {Key? key,
      required SignInController controller,
      required this.outlineInputBorder,
      required this.errorOutlineInputBorder})
      : _controller = controller,
        super(key: key);

  final SignInController _controller;
  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder errorOutlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller.emailController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          FeatherIcons.mail,
          size: 22,
          color: colors.blackColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        errorBorder: errorOutlineInputBorder,
        focusedErrorBorder: errorOutlineInputBorder,
        hintText: strings.usernamePlaceholder,
      ),
      validator: _controller.validateEmail,
    );
  }
}
