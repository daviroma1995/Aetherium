import 'package:flutter/material.dart';

class AuthFormStateProvider implements ChangeNotifier {
  final Map _formStates = {'signInPressed': false, 'obscureText': false};

  bool get isObscureText {
    return _formStates['obscureText'];
  }

  bool get isSignInPressed {
    return _formStates['signInPressed'];
  }

  void toggle(formState) {
    _formStates[formState] = !_formStates[formState];
  }

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    notifyListeners();
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }
}
