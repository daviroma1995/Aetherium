import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'qr_code_controller.dart';

class QrCodeScreen extends StatelessWidget {
  final controller = Get.put(QrCodeController());
  QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDark ? AppColors.BACKGROUND_DARK : AppColors.BACKGROUND_COLOR,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(25.0),
              onTap: () => controller.handleBack(),
              child: Container(
                alignment: Alignment.center,
                width: 25.0,
                height: 25.0,
                child: SvgPicture.asset(AppAssets.BACK_ARROW, height: 14.0, width: 14.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Text('Qr Code', style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      body: Center(
        child: QrImageView(
          data: Get.arguments ?? 'ERROR',
          size: 300,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
