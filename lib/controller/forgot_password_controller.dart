import 'package:aetherium_salon/core/state_management/state_management.dart';
import 'package:aetherium_salon/handler/auth_exception_handler.dart';
import 'package:aetherium_salon/service/auth_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordController extends Controller {
  late final TextEditingController emailController;
  final Map _formState = {'signInPressed': false, 'obscureText': false};
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    super.save = false;
    emailController = TextEditingController();
  }

  String? validateEmail(String? value) {
    if (!_formState['signInPressed']) return null;
    if ((value!.isEmpty || !value.contains('@'))) {
      return 'Inserire una mail valida';
    }
    return null;
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    return _authService.resetPassword(email: email);
  }

  void toggle(state) {
    _formState[state] = !_formState[state];
    update();
  }

  @override
  String getTag() {
    return "forgot_password_controller";
  }
}
