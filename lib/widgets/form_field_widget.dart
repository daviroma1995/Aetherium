import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomInputFormField extends StatelessWidget {
  final String iconUrl;
  final String hintText;
  final bool isObsecure;
  final bool isPassword;
  final bool isValid;
  final Function onSubmit;
  final Function? onPressed;
  final bool autoFocus;
  final TextEditingController textEdigintController;

  const CustomInputFormField({
    super.key,
    required this.textEdigintController,
    this.iconUrl = '',
    required this.hintText,
    required this.isValid,
    required this.onSubmit,
    this.onPressed,
    this.isObsecure = false,
    this.isPassword = false,
    this.autoFocus = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      height: 50.0,
      decoration: BoxDecoration(
        border:
            Border.all(color: isValid ? AppColors.BORDER_COLOR : Colors.red),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: textEdigintController,
        onSubmitted: (value) => onSubmit(),
        autofocus: autoFocus,
        style: const TextStyle(
          color: AppColors.BLACK_COLOR,
          fontWeight: FontWeight.w500,
        ),
        obscureText: isObsecure,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.GREY_COLOR,
            fontWeight: FontWeight.w500,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () => onPressed!(),
                  icon: isObsecure
                      ? const Icon(Icons.visibility_off_outlined, size: 20.0)
                      : const Icon(Icons.visibility_outlined, size: 20.0),
                )
              : null,
          contentPadding: const EdgeInsets.all(0.0),
          prefixIcon: iconUrl != ''
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 12.0, right: 20.0),
                  child: SvgPicture.asset(iconUrl),
                )
              : null,
        ),
      ),
    );
  }
}
