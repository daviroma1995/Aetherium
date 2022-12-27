import 'package:flutter/material.dart';
import 'package:aetherium_salon/utils/colors.dart' as colors;
import 'package:aetherium_salon/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';

InputDecoration commonInputDecoration(
    {String? hintText, Widget? prefixIcon, Widget? suffixIcon}) {
  return InputDecoration(
    filled: true,
    fillColor: colors.textFieldColor,
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    hintStyle: TextStyle(color: colors.hintTextColor, fontSize: 16),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
  );
}

Widget homeTitleWidget({
  String? titleText,
  String? viewAllText,
  Function()? onAllTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titleText!,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        TextButton(
          onPressed: onAllTap!,
          child: Text(
            viewAllText ?? "View All",
            style: const TextStyle(
                color: colors.viewAllColor,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    ),
  );
}

Widget text(
  String? text, {
  var fontSize = textSizeLargeMedium,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 1,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  TextDecoration decoration = TextDecoration.none,
  bool underlined = false,
}) {
  return Text(textAllCaps ? text!.toUpperCase() : text!,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor ?? colors.secondaryColor,
          height: 1.5,
          letterSpacing: latterSpacing,
          decoration: decoration));
}

Widget drawerWidget(
    {String? drawerTitle, Function()? drawerOnTap, IconData? drawerIcon}) {
  return ListTile(
    horizontalTitleGap: 0,
    visualDensity: VisualDensity.compact,
    leading: Icon(drawerIcon!, size: 20),
    title: Text(drawerTitle!, style: const TextStyle()),
    onTap: drawerOnTap!,
  );
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: colors.whiteColor,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

// ignore: must_be_immutable
class EditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var hint;
  var maxLine;
  TextEditingController? mController;

  VoidCallback? onPressed;

  EditText(
      {var this.fontSize = textSizeNormal,
      var this.textColor = colors.secondaryColor,
      var this.fontFamily = fontRegular,
      var this.isPassword = true,
      var this.hint = "",
      var this.isSecure = false,
      var this.text = "",
      var this.mController,
      var this.maxLine = 1});

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  get viewColor => null;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.mController,
      obscureText: widget.isPassword,
      style: const TextStyle(
          color: colors.primaryColor,
          fontSize: textSizeLargeMedium,
          fontFamily: fontRegular),
      decoration: InputDecoration(
        suffixIcon: widget.isSecure
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                },
                child: Icon(
                  widget.isPassword ? Icons.visibility : Icons.visibility_off,
                  color: colors.iconColorPrimary,
                ),
              )
            : null,
        contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        hintText: widget.hint,
        hintStyle: const TextStyle(color: colors.textColorGrey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: colors.viewColor, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: colors.viewColor, width: 0.0),
        ),
      ),
    );
  }
}

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}
