import 'dart:developer';

import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/utils/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/image_picker.dart';
import '../../models/client.dart';

class AccountInfoController extends GetxController {
  String uid = '';
  var currentClient = Client().obs;
  @override
  void onInit() async {
    super.onInit();
    uid = await FirebaseSerivces.checkUserUid();
    await getUserInfo();
  }

  @override
  void onReady() async {
    super.onReady();
    imageFileString.value = LocalData.imageUrlString;
  }

  RxString genderValue = 'Male'.obs;
  Rx<XFile?> imageUrl = XFile('').obs;
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

  void pickImageFromMobile(context) async {
    var image = await kImagePicker(context);
    if (image == null) {
      return;
    } else {
      imageFileString.value = image.path;
      LocalData.setImageUrlString(image.path);
      isUpdating.value = !isUpdating.value;
    }
  }

  Future<void> getUserInfo() async {
    try {
      var data = await FirebaseSerivces.getDataWhere(
          collection: 'clients', key: 'user_id', value: uid);
      currentClient.value = Client.fromJson(data!);
    } on Exception catch (ex) {
      log(ex.toString());
    }
  }
}
