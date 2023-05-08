import 'package:atherium_saloon_app/utils/shared_preferences.dart';
import 'package:get/get.dart';

import '../../models/client.dart';

class AddNewClientController extends GetxController {
  String uid = '';
  var currentClient = Client().obs;
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    imageFileString.value = LocalData.imageUrlString;
  }

  RxString genderValue = 'Male'.obs;
  RxBool isUpdating = false.obs;
  RxString imageFileString = ''.obs;
  final dateOfBirth = DateTime.now().obs;
  String get getDateOfBirth {
    final day = dateOfBirth.value.day < 10
        ? '0${dateOfBirth.value.day}'
        : dateOfBirth.value.day.toString();
    final month = dateOfBirth.value.month < 10
        ? '0${dateOfBirth.value.month}'
        : dateOfBirth.value.month.toString();
    return '$day/$month/${dateOfBirth.value.year}';
  }

  void changeValue(String value) {
    genderValue.value = value;
  }

  void handleBack() {
    Get.back();
  }
}
