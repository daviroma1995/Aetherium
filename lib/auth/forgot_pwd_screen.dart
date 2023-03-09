import 'package:aetherium_salon/controller/forgot_pwd_controller.dart';
import 'package:aetherium_salon/core/state_management/state_management.dart';
import 'package:aetherium_salon/fragments/auth/email_field.dart';
import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';

import 'package:aetherium_salon/utils/colors.dart' as colors;
import 'package:aetherium_salon/utils/strings.dart' as strings;
import 'package:aetherium_salon/utils/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late OutlineInputBorder outlineInputBorder;
  late OutlineInputBorder errorOutlineInputBorder;
  late ForgotPwdController controller;

  @override
  void initState() {
    super.initState();

    controller = ControllerStore.putOrFind(ForgotPwdController());

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
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: EmailField(
                    controller: controller.emailController,
                    outlineInputBorder: outlineInputBorder,
                    errorOutlineInputBorder: errorOutlineInputBorder,
                  )),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      alignment: Alignment.center,
                      height: width / 8,
                      decoration: BoxDecoration(
                          color: colors.buttonColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            controller.resetPassword(
                                email: controller.emailController.text);
                          },
                          child: Container(
                              margin: const EdgeInsets.only(right: 16),
                              alignment: Alignment.center,
                              height: width / 8,
                              child: text(strings.sendLabel,
                                  textColor: whiteColor, isCentered: true)),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
