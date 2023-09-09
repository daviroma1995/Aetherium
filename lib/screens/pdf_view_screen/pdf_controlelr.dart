import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart' as directory;

class PdfController extends GetxController {
  RxBool isLoading = true.obs;
  PdfController({required this.url});
  String url;
  RxString pdfUrl = ''.obs;
  Future<String> loadPdf() async {
    var response = await http.get(Uri.parse(url));
    var dir = await directory.getTemporaryDirectory();
    File file = File("${dir.path}/data.pdf");
    await file.writeAsBytes(response.bodyBytes, flush: true);
    return file.path;
  }

  @override
  void onInit() async {
    pdfUrl.value = await loadPdf();
    super.onInit();
    isLoading.value = false;
  }
}
