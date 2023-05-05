// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:atherium_saloon_app/utils/constants.dart';

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
  final double paddingSymetric;
  final double paddingVertical;
  final Function? onchange;
  final Function? onFocus;
  final String? initialValue;
  final int? maxLines;
  final int? minLInes;
  const CustomInputFormField({
    Key? key,
    this.iconUrl = '',
    required this.hintText,
    this.isObsecure = false,
    this.isPassword = false,
    required this.isValid,
    required this.onSubmit,
    this.onPressed,
    this.autoFocus = true,
    required this.textEdigintController,
    this.paddingSymetric = 0.0,
    this.paddingVertical = 0.0,
    this.onchange,
    this.onFocus,
    this.initialValue,
    this.maxLines,
    this.minLInes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.only(left: 0.0),
      decoration: BoxDecoration(
        border: !isDark
            ? Border.all(color: isValid ? AppColors.BORDER_COLOR : Colors.red)
            : const Border(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: TextField(
          onTap: () {
            if (onFocus == null) {
              () {};
            } else {
              onFocus!();
            }
          },
          onChanged: (value) {
            if (onchange == null) {
              () {};
            } else {
              return onchange!(value);
            }
          }, //=> onchange!(value) ?? (value) {},
          cursorColor: isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
          controller: textEdigintController,
          maxLines: maxLines ?? 1,
          minLines: minLInes ?? 1,
          onSubmitted: (value) => onSubmit(),
          autofocus: autoFocus,
          style: Theme.of(context).textTheme.bodyMedium,
          obscureText: isObsecure,
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? AppColors.PRIMARY_DARK : AppColors.WHITE_COLOR,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
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
            contentPadding: EdgeInsets.symmetric(
                horizontal: paddingSymetric, vertical: paddingVertical),
            prefixIcon: iconUrl != ''
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, bottom: 12.0, right: 20.0, left: 18.0),
                    child: SvgPicture.asset(iconUrl,
                        colorFilter: isDark
                            ? const ColorFilter.mode(
                                AppColors.GREY_COLOR, BlendMode.srcIn)
                            : const ColorFilter.mode(
                                AppColors.GREY_DARK, BlendMode.srcIn)),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
