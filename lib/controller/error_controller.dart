import 'package:aetherium_salon/core/state_management/controller.dart';
import 'package:aetherium_salon/screens/main/channel_app_screen.dart';

import 'package:flutter/material.dart';

class ErrorController extends Controller {
  ErrorController();

  void goToHomePage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ChannelScreen()),
      (route) => false,
    );
  }

  @override
  String getTag() {
    return "error_controller";
  }
}
