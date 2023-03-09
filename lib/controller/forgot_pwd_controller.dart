import 'package:aetherium_salon/core/state_management/controller.dart';
import 'package:aetherium_salon/handler/auth_exception_handler.dart';
import 'package:aetherium_salon/service/auth_service.dart';

import 'package:flutter/material.dart';

class ForgotPwdController extends Controller {
  late final TextEditingController _emailController;
  late final AuthService _authService;
  GlobalKey<FormState> formKey = GlobalKey();

  ForgotPwdController()
      : _authService = AuthService(),
        _emailController = TextEditingController(),
        super();

  TextEditingController get emailController => _emailController;

  Future<AuthStatus> resetPassword({required String email}) async {
    if (formKey.currentState!.validate()) {
      return _authService.resetPassword(email: email);
    }
    return AuthStatus.unknown;
  }

  @override
  String getTag() {
    return "forgot_pwd_controller";
  }
}
