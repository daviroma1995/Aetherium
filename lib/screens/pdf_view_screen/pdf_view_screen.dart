// ignore_for_file: avoid_print

import 'package:atherium_saloon_app/screens/pdf_view_screen/pdf_controlelr.dart';
import 'package:atherium_saloon_app/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

class PdfViewScreen extends StatelessWidget {
  const PdfViewScreen({super.key, required this.path, required this.title});
  final String path;
  final String title;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PdfController(url: path));
    return Scaffold(
        appBar: AppBarCustom(
          onTap: () {
            Get.back();
          },
          title: title,
        ),
        body: Obx(
          () => controller.isLoading.value
              ? SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SafeArea(
                  child: Visibility(
                    visible: !controller.isLoading.value,
                    child: PDFView(
                      filePath: controller.pdfUrl.value,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: false,
                      pageFling: false,
                      onError: (error) {
                        print(error.toString());
                      },
                      onPageError: (page, error) {
                        print('$page: ${error.toString()}');
                      },
                    ),
                  ),
                ),
        ));
  }
}
