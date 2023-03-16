import 'dart:developer';

import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isObsecure = true.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;
  RxString emailErrorMessage = ''.obs;
  RxString passwordErrorMessage = ''.obs;
  void hideOrShowPassword() {
    isObsecure.value = !isObsecure.value;
  }

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

  void validatePassword() {
    if (passwordController.text.length < 8) {
      isPasswordValid.value = false;
      passwordErrorMessage.value =
          AppLanguages.PASSWORD_MUST_BE_8_CHARACTERS_LONG;
    } else {
      isPasswordValid.value = true;
      passwordErrorMessage.value = '';
    }
  }

  void navigator() {
    validateEmail();
    validatePassword();
    if (isEmailValid.value && isPasswordValid.value) {
      Get.offAll(BottomNavigationScreen());
    } else {
      log('rrror');
    }
  }
}
