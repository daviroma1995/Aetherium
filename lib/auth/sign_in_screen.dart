import 'package:aetherium_salon/controller/sign_in_controller.dart';
import 'package:aetherium_salon/core/state_management/state_management.dart';
import 'package:aetherium_salon/fragments/auth/email_field.dart';
import 'package:aetherium_salon/fragments/auth/password_field.dart';
import 'package:aetherium_salon/utils/spacing.dart';
import 'package:flutter/material.dart';

import 'package:aetherium_salon/utils/colors.dart' as colors;
import 'package:aetherium_salon/utils/constant.dart' as constants;
import 'package:aetherium_salon/utils/strings.dart' as strings;
import 'package:aetherium_salon/utils/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInScreen extends StatefulWidget {
  static String tag = '/SignIn';

  const SignInScreen({super.key});

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignInScreen> {
  late OutlineInputBorder outlineInputBorder;
  late OutlineInputBorder errorOutlineInputBorder;
  late SignInController controller;

  @override
  void initState() {
    super.initState();

    controller = ControllerStore.putOrFind(SignInController());

    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: colors.viewColor, width: 0.8),
    );
    errorOutlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: colors.redColor, width: 0.8),
    );
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(colors.whiteColor);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: controller.formKey,
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
                margin: Spacing.all(24),
                decoration: boxDecoration(
                    bgColor: colors.blueColor, showShadow: true, radius: 4),
                padding: Spacing.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    EmailField(
                      controller: controller.emailController,
                      outlineInputBorder: outlineInputBorder,
                      errorOutlineInputBorder: errorOutlineInputBorder,
                    ),
                    Spacing.height(20),
                    PasswordField(
                        controller: controller.passwordController,
                        outlineInputBorder: outlineInputBorder,
                        errorOutlineInputBorder: errorOutlineInputBorder),
                    Spacing.height(10),
                    InkWell(
                      onTap: () {
                        controller.goToForgotPasswordScreen(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 10),
                        child: text(strings.pwdForgotPlaceholder,
                            textColor: Theme.of(context).primaryColor,
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
                          child: Container(
                            margin: Spacing.right(8),
                            alignment: Alignment.center,
                            height: width / 8,
                            decoration: BoxDecoration(
                                color: colors.buttonColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  controller.signIn(context);
                                },
                                child: Container(
                                    margin: Spacing.right(16),
                                    alignment: Alignment.center,
                                    height: width / 8,
                                    child: text(strings.loginLabel,
                                        textColor: whiteColor,
                                        isCentered: true)),
                              ),
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
