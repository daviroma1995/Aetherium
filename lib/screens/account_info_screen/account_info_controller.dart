import 'package:get/get.dart';

class AccountInfoController extends GetxController {
  RxString genderValue = 'Male'.obs;
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
}
