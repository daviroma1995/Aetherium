// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/screens/login_screen/login_controller.dart';
import 'package:get/get.dart';

import '../../models/consultation.dart';

class ConsultationsController extends GetxController {
  RxBool isLoading = true.obs;
  var consultations = <Consultation>[].obs;
  List<String> urls = <String>[].obs;

  @override
  void onInit() async {
    var uid = LoginController.instance.auth.currentUser!.uid;
    consultations.value = await FirebaseServices.getConsultations(uid);
    if (consultations.isNotEmpty) {
      var filePathString = [];
      for (var consultation in consultations) {
        filePathString.add(consultation.filePathList!);
      }
      var listOfFilePaths = [];
      for (var filePath in filePathString) {
        listOfFilePaths = filePath[0].split(', ');
      }

      for (String path in listOfFilePaths) {
        var url = await FirebaseServices.getDownloadUrl(path);
        urls.add(url);
      }
    }
    isLoading.value = false;

    super.onInit();
  }

  void handleBack() {
    Get.back();
  }
}

// class Consultation {
//   final String title;
//   final String subTitle;
//   Consultation({
//     required this.title,
//     required this.subTitle,
//   });
// }

// List<Consultation> consultations = [
//   Consultation(title: 'Ayse Cam', subTitle: 'Ultra-Shine Nourishing Lipsting'),
//   Consultation(title: 'Imdat Cimsit', subTitle: 'Weightless Foundation'),
//   Consultation(title: 'Kamile Kurtoglu', subTitle: 'Waterproof Eye Pencil'),
//   Consultation(
//       title: 'Sefika Gulsen Yildiz', subTitle: 'Velvet Plush Lipstick'),
//   Consultation(title: 'Ayse Cam', subTitle: 'Ultra-Shine Nourishing Lipsting'),
//   Consultation(title: 'Imdat Cimsit', subTitle: 'Weightless Foundation'),
//   Consultation(title: 'Kamile Kurtoglu', subTitle: 'Waterproof Eye Pencil'),
//   Consultation(
//       title: 'Sefika Gulsen Yildiz', subTitle: 'Velvet Plush Lipstick'),
// ];
