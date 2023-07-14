// ignore_for_file: avoid_print

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  RxBool isEmailValid = true.obs;
  RxString emailErrorMessage = ''.obs;
  RxBool isLoading = false.obs;
  var key = GlobalKey<FormState>();
  void validateEmail() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    if (emailController.text.isEmpty) {
      isEmailValid.value = false;
      emailErrorMessage.value = tr('email_should_not_be_empty');
    } else if (!regExp.hasMatch(emailController.text)) {
      isEmailValid.value = false;
      emailErrorMessage.value = tr('email_is_not_valid');
    } else {
      isEmailValid.value = true;
      emailErrorMessage.value = '';
    }
  }

  void sendResetEmail() async {
    isLoading.value = true;
    validateEmail();
    if (isEmailValid.value == true) {
      String email = emailController.text;
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Fluttertoast.showToast(
            msg: '${tr('a_password_reset_email_has_been_sent_to')} $email');
        Timer(const Duration(seconds: 1), () {
          Get.back();
        });
      } on FirebaseAuthException catch (err) {
        print(err.code);
        if (err.code == "user-not-found") {
          Fluttertoast.showToast(msg: tr('user_not_found'));
        } else {
          Fluttertoast.showToast(msg: err.code);
        }
      }
    }
    isLoading.value = false;
  }
}
