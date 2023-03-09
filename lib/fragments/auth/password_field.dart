import 'package:aetherium_salon/validator/string_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:aetherium_salon/utils/colors.dart' as colors;
import 'package:aetherium_salon/utils/strings.dart' as strings;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final obscureStateProvider = StateProvider<bool>(
  // We return the default sort type, here name.
  (ref) => true,
);

class PasswordField extends ConsumerWidget {
  const PasswordField({
    Key? key,
    required final TextEditingController controller,
    required this.outlineInputBorder,
    required this.errorOutlineInputBorder,
  })  : _controller = controller,
        super(key: key);

  final OutlineInputBorder outlineInputBorder;
  final OutlineInputBorder errorOutlineInputBorder;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: _controller,
      obscureText: ref.watch(obscureStateProvider),
      decoration: InputDecoration(
          prefixIcon: const Icon(
            FeatherIcons.lock,
            size: 22,
            color: colors.fontColor,
          ),
          suffixIcon: InkWell(
              onTap: () {
                ref.read(obscureStateProvider.notifier).state =
                    !ref.read(obscureStateProvider.notifier).state;
              },
              child: Icon(ref.watch(obscureStateProvider)
                  ? Icons.visibility_off
                  : Icons.visibility)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          errorBorder: errorOutlineInputBorder,
          focusedErrorBorder: errorOutlineInputBorder,
          hintText: strings.pwdPlaceholder,
          hintStyle: const TextStyle(color: colors.fontColor)),
      validator: StringUtils.validatePassword,
    );
  }
}
