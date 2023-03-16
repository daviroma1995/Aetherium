import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  RxBool isEmailValid = true.obs;
  RxString emailErrorMessage = ''.obs;

  void validateEmail() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (emailController.text.isEmpty) {
      emailErrorMessage.value = AppLanguages.EMAIL_SHOULD_NOT_BE_EMPTY;
    } else if (!regExp.hasMatch(emailController.text)) {
      isEmailValid.value = false;
      emailErrorMessage.value = AppLanguages.EMAIL_IS_NOT_VALID;
    } else {
      isEmailValid.value = true;
      emailErrorMessage.value = '';
    }
  }
}
