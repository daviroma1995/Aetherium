import 'package:aetherium_salon/auth/sign_in_forgot_pwd_screen.dart';
import 'package:aetherium_salon/core/state_management/controller.dart';
import 'package:aetherium_salon/handler/auth_exception_handler.dart';
import 'package:aetherium_salon/service/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInController extends Controller {
  SignInController();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final Map _formState = {'signInPressed': false, 'obscureText': false};
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    super.save = false;
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  String? validateEmail(String? value) {
    if (!_formState['signInPressed']) return null;
    if ((value!.isEmpty || !value.contains('@'))) {
      return 'Inserire una mail valida';
    }
    return null;
  }

  bool get isObscureText => _formState['isObscureText'];
  bool get isSigninPressed => _formState['isSigninPressed'];

  String? validatePassword(String? value) {
    if (!_formState['signInPressed']) return null;
    if (value!.isEmpty) {
      return 'Inserisci una Password';
    }
    if (value.length < 6) {
      return 'La password deve contenere almeno 6 caratteri';
    }
    return null;
  }

  void toggle(state) {
    _formState[state] = !_formState[state];
    update();
  }

  void goToForgotPasswordScreen() {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      ),
    );
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    return _authService.resetPassword(email: email);
  }

  void signIn() async {
    final email = emailController.text;
    final password = passwordController.text;

    final status = await _authService.signIn(email: email, password: password);

    log('_status is: $status');
  }

  @override
  String getTag() {
    return "sign_in_controller";
  }
}
