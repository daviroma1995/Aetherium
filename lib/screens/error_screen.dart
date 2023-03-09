import 'package:aetherium_salon/controller/error_controller.dart';
import 'package:aetherium_salon/core/state_management/state_management.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:aetherium_salon/utils/colors.dart' as colors;

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  late ErrorController controller;

  @override
  void initState() {
    setStatusBarColor(const Color(0xFFF9FAFB));
    controller = ControllerStore.putOrFind(ErrorController());
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarColor(colors.fontColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset('images/errors/error.png',
                fit: BoxFit.cover, height: context.height()),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Error!',
                    style: boldTextStyle(size: 30, color: Colors.black)),
                16.height,
                Text(
                  'Something went wrong, Please try again later',
                  style: primaryTextStyle(size: 18, color: Colors.black54),
                  textAlign: TextAlign.center,
                ).paddingSymmetric(vertical: 8, horizontal: 40),
                32.height,
                AppButton(
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius(30)),
                  color: context.cardColor,
                  elevation: 10,
                  padding: const EdgeInsets.all(16),
                  onTap: () {
                    controller.goToHomePage(context);
                  },
                  child: Text('HOME', style: boldTextStyle())
                      .paddingSymmetric(horizontal: 32),
                ),
                100.height,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
