import 'package:aetherium_salon/auth/forgot_pwd_screen.dart';
import 'package:aetherium_salon/controller/info_controller.dart';
import 'package:aetherium_salon/core/state_management/controller.dart';
import 'package:aetherium_salon/handler/auth_exception_handler.dart';
import 'package:aetherium_salon/screens/main/channel_app_screen.dart';
import 'package:aetherium_salon/service/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInController extends Controller {
  late final TextEditingController _emailController, _passwordController;
  late final AuthService _authService;
  GlobalKey<FormState> formKey = GlobalKey();

  SignInController()
      : _authService = AuthService(),
        _emailController = TextEditingController(),
        _passwordController = TextEditingController(),
        super();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  void signIn(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      log("form validation passed");

      final email = _emailController.text;
      final password = _passwordController.text;

      AuthStatus authStatus = await _authService.signIn(email: email, password: password);
      log("authStatus is:  $authStatus");
      if (authStatus == AuthStatus.successful) {
        log("login successful");
        log("mounted is: $mounted");
        Info.message("OK", context: context);
        if (!mounted) return;
        goToChannelScreen(context);
        return;
      }
      Info.error(AuthExceptionHandler.generateErrorMessage(authStatus));
    }
  }

  void goToChannelScreen(BuildContext context) {
    Navigator.of(context, rootNavigator: false).push(
      MaterialPageRoute(
        builder: (context) => const ChannelScreen(),
      ),
    );
  }

  void goToForgotPasswordScreen(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      ),
    );
  }

  @override
  String getTag() {
    return "sign_in_controller";
  }
}
