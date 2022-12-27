import 'package:aetherium_salon/controller/sign_in_controller.dart';
import 'package:aetherium_salon/core/state_management/controller_store.dart';
import 'package:aetherium_salon/fragments/auth/email_field.dart';
import 'package:aetherium_salon/fragments/auth/password_field.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:aetherium_salon/utils/colors.dart' as colors;
import 'package:aetherium_salon/utils/constant.dart' as constants;
import 'package:aetherium_salon/utils/strings.dart' as strings;
import 'package:aetherium_salon/utils/widgets.dart';

class SignInScreen extends StatefulWidget {
  static String tag = '/SignIn';

  const SignInScreen({super.key});

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late OutlineInputBorder outlineInputBorder;
  late OutlineInputBorder errorOutlineInputBorder;
  late SignInController controller;

  @override
  Widget build(BuildContext context) {
    changeStatusColor(colors.whiteColor);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    controller = ControllerStore.putOrFind(SignInController());

    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: colors.viewColor, width: 0.8),
    );
    errorOutlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: colors.redColor, width: 0.8),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Container(
          height: height,
          alignment: Alignment.center,
          color: colors.whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logo(width),
              title(),
              Container(
                margin: const EdgeInsets.all(24),
                decoration: boxDecoration(
                    bgColor: colors.blueColor, showShadow: true, radius: 4),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: EmailField(
                          controller: controller,
                          outlineInputBorder: outlineInputBorder,
                          errorOutlineInputBorder: errorOutlineInputBorder,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: PasswordField(
                          controller: controller,
                          outlineInputBorder: outlineInputBorder,
                          errorOutlineInputBorder: errorOutlineInputBorder),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        toasty(context, strings.pwdForgotPlaceholder);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 10),
                        child: text(strings.pwdForgotPlaceholder,
                            textColor: colors.primaryColor,
                            fontSize: constants.textSizeLargeMedium,
                            fontFamily: constants.fontSemibold),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                controller.signIn();
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                  color: colors.appDarkRed,
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              height: width / 8,
                              child: text(strings.loginLabel,
                                  textColor: whiteColor, isCentered: true),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                                constants.fingerprintImgPath,
                                width: width / 8.2,
                                color: viewLineColor))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget logo(double width) {
    return Image.asset(constants.logiImgPath,
        width: width / 2.5, height: width / 2.5);
  }

  Widget title() {
    return text(strings.loginHeader,
        textColor: colors.primaryColor,
        fontFamily: constants.fontBold,
        fontSize: 22.0);
  }
}
