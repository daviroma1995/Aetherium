import 'package:aetherium_salon/controller/sign_in_controller.dart';
import 'package:aetherium_salon/core/state_management/controller_store.dart';
import 'package:aetherium_salon/fragments/auth/email_field.dart';
import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:aetherium_salon/utils/colors.dart' as colors;
import 'package:aetherium_salon/utils/constant.dart' as constants;
import 'package:aetherium_salon/utils/strings.dart' as strings;
import 'package:aetherium_salon/utils/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
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
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: EmailField(
                    controller: controller,
                    outlineInputBorder: outlineInputBorder,
                    errorOutlineInputBorder: errorOutlineInputBorder,
                  )),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          controller.resetPassword(
                              email: controller.emailController.text);
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
                      child: SvgPicture.asset(constants.fingerprintImgPath,
                          width: width / 8.2, color: viewLineColor))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
