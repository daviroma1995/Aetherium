import 'package:get/get.dart';

class AccountInfoController extends GetxController {
  RxString genderValue = 'Male'.obs;

  void changeValue(String value) {
    genderValue.value = value;
  }
}
