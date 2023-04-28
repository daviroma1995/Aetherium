import 'package:atherium_saloon_app/screens/bottom_navigation_scren/bottom_navigation_screen.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_screen.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../forget_password_screen/foreget_password_screen.dart';
import '../splash_screen/splash_controller.dart';
import '../splash_screen/splash_screen.dart';

class LoginController extends GetxController {
  // Auth controller instance..
  static LoginController instance = Get.find();
  // email passowrd, udername
  late Rx<User?> _user;
  // Firebase auth
  User get user => _user.value!;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      SplashScreenController controller = Get.find();
      controller.navigate();
    } else {
      Get.offAll(const BottomNavigationScreen());
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
          'Sign In Failed',
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

  void logout() async {
    await auth.signOut();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
      emailErrorMessage.value = AppLanguages.EMAIL_SHOULD_NOT_BE_EMPTY;
      isEmailValid.value = false;
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
        msg: 'Login Successfull',
        backgroundColor: Colors.green,
      );
      loadingHandler();
      _currentUserUid = auth.currentUser!.uid;
      // LocalData.setIsLogedIn(true);
      // LocalData.setUid(_currentUserUid!);
      // log(auth.currentUser!.emailVerified.toString());
      // Get.offAll(
      //   () => const BottomNavigationScreen(),
      //   arguments: {"uid": _currentUserUid},
      // );
    } on FirebaseAuthException catch (err) {
      if (err.code == "wrong-password") {
        loadingHandler();
        Fluttertoast.showToast(
          msg: 'You entered wrong password',
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
