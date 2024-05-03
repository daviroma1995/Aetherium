import 'dart:async';

import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../network_utils/firebase_messaging.dart';
import '../../utils/shared_preferences.dart';
import '../forget_password_screen/foreget_password_screen.dart';
import '../splash_screen/splash_controller.dart';

class LoginController extends GetxController {
  final auth = FirebaseAuth.instance;
  // Auth controller instance..

  // email passowrd, udername
  final User? _user = FirebaseAuth.instance.currentUser;
  // Firebase auth

  User? get user {
    return _user;
  }

  _initialScreen() async {
    if (_user == null) {
      final controller = Get.put(SplashScreenController());
      controller.navigate();
    } else {
      Timer(const Duration(milliseconds: 2000), () {
        Get.offAll(() => const BottomNavigationScreen());
      });
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About User",
        "User message",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        titleText: const Text(
          'Account Creation Failed',
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About User",
        "User message",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        titleText: const Text(
          'sign_in_failed',
          style: TextStyle(color: Colors.white),
        ).tr(),
        messageText: Text(
          e.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  void logout() async {
    LocalData.setIsLogedIn(false);
<<<<<<< HEAD
    await NotificationsSubscription.fcmUnSubscribe(
        appUserId: FirebaseAuth.instance.currentUser!.uid);
=======
    Future.wait([
      NotificationsSubscription.fcmUnSubscribe(
          appUserId: FirebaseAuth.instance.currentUser!.uid),
      NotificationsSubscription.fcmUnSubscribe(appUserId: 'client'),
      NotificationsSubscription.fcmUnSubscribe(appUserId: 'admin'),
    ]);
>>>>>>> a7b79b91bb16a5abae7fea901dc01f535a0ebb5e
    await auth.signOut();
    Get.offAll(() => LoginScreen());
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ignore: unused_field
  late String? _currentUserUid;
  RxBool isObsecure = true.obs;
  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;
  RxBool isLoading = false.obs;
  RxString emailErrorMessage = ''.obs;
  RxString passwordErrorMessage = ''.obs;
  void hideOrShowPassword() {
    isObsecure.value = !isObsecure.value;
  }

  void validateEmail() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    if (emailController.text.isEmpty) {
      emailErrorMessage.value = tr('email_should_not_be_empty');
      isEmailValid.value = false;
    } else if (!regExp.hasMatch(emailController.text)) {
      isEmailValid.value = false;
      emailErrorMessage.value = tr('email_is_not_valid');
    } else {
      isEmailValid.value = true;
      emailErrorMessage.value = '';
    }
  }

  void validatePassword() {
<<<<<<< HEAD
    if (passwordController.text.length < 6) {
=======
    if (passwordController.text.length < 8) {
>>>>>>> a7b79b91bb16a5abae7fea901dc01f535a0ebb5e
      isPasswordValid.value = false;
      passwordErrorMessage.value = tr('password_must_be_8_characters_long');
    } else {
      isPasswordValid.value = true;
      passwordErrorMessage.value = '';
    }
  }

  void navigator() async {
    validateEmail();
    validatePassword();
    if (isEmailValid.value && isPasswordValid.value) {
      await loginToDataBase(emailController.text, passwordController.text);
    }
  }

  void navigateToForgetPassword() {
    Get.to(
      () => ForgetPasswordScreen(),
    );
  }

  void loadingHandler() {
    isLoading.value = !isLoading.value;
  }

  Future<void> loginToDataBase(String email, String password) async {
    try {
      loadingHandler();
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(
        msg: tr('login_successfull'),
        backgroundColor: Colors.green,
      );
      loadingHandler();
      _currentUserUid = auth.currentUser!.uid;
      var categories = await FirebaseServices.getTreatmentCategories();
      Get.offAll(
        () => const BottomNavigationScreen(),
        arguments: categories,
      );
    } on FirebaseAuthException catch (err) {
      if (err.code == "wrong-password") {
        loadingHandler();
        Fluttertoast.showToast(
          msg: tr('you_entered_wrong_password'),
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        loadingHandler();
        Fluttertoast.showToast(
            msg: err.code.replaceAll('-', ' '),
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    }
  }
}
