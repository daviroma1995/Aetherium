import 'package:aetherium_salon/controller/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:aetherium_salon/utils/colors.dart' as colors;
import 'package:aetherium_salon/utils/strings.dart' as strings;

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required SignInController controller,
    required this.outlineInputBorder,
    required this.errorOutlineInputBorder,
  })  : _controller = controller,
        super(key: key);

  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder errorOutlineInputBorder;
  final SignInController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller.passwordController,
      obscureText: _controller.isObscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          FeatherIcons.lock,
          size: 22,
          color: colors.blackColor,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: IconButton(
            icon: Icon(
                _controller.isObscureText
                    ? Icons.visibility_off
                    : Icons.visibility,
                size: 18),
            onPressed: () {
              _controller.toggle('obscureText');
            },
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        errorBorder: errorOutlineInputBorder,
        focusedErrorBorder: errorOutlineInputBorder,
        hintText: strings.pwdPlaceholder,
      ),
      validator: _controller.validatePassword,
    );
  }
}
