import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double width;
  final Color color;
  final String buttonText;
  final Color buttonTextColor;
  final bool bordered;
  final Color borderColor;
  final Function onTap;
  const PrimaryButton({
    super.key,
    required this.width,
    required this.buttonText,
    this.bordered = false,
    this.color = Colors.transparent,
    this.buttonTextColor = Colors.white,
    this.borderColor = const Color(0xffE2E8F0),
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: 42.0,
      decoration: BoxDecoration(
        border: bordered ? Border.all(color: borderColor) : null,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: MaterialButton(
          onPressed: () => onTap(),
          highlightColor: color,
          minWidth: width,
          height: 42.0,
          color: color,
          elevation: 0.0,
          child: Text(
            buttonText,
            style: TextStyle(
              color: buttonTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 14.0,
            ),
          ).tr(),
        ),
      ),
    );
  }
}

extension Loading on PrimaryButton {
  Widget loading(bool isLoading, {required Color loadingColor}) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: 42.0,
      decoration: BoxDecoration(
        border: bordered ? Border.all(color: borderColor) : null,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: MaterialButton(
          onPressed: () => onTap(),
          highlightColor: color,
          minWidth: width,
          height: 42.0,
          color: color,
          elevation: 0.0,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: loadingColor,
                  ),
                )
              : Text(
                  buttonText,
                  style: TextStyle(
                    color: buttonTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                  ),
                ).tr(),
        ),
      ),
    );
  }
}
