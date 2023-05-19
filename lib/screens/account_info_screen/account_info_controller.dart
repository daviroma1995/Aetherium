import 'dart:developer';

import 'package:atherium_saloon_app/network_utils/firebase_services.dart';
import 'package:atherium_saloon_app/utils/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/image_picker.dart';
import '../../models/client.dart';
import '../login_screen/login_controller.dart';
import '../login_screen/login_screen.dart';

class AccountInfoController extends GetxController {
  String uid = '';
  var currentClient = Client().obs;
  TextEditingController name = TextEditingController();
  TextEditingController surName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  RxBool nameHasError = false.obs;
  RxBool surNameHasError = false.obs;
  RxBool emailHasError = false.obs;
  RxBool phoneHasError = false.obs;
  RxBool addressHasError = false.obs;
  RxBool isLoading = false.obs;
  RxString nameErrorMessage = ''.obs;
  RxString surNameErrorMessage = ''.obs;
  RxString emailErrorMessage = ''.obs;
  RxString phoneErrorMessage = ''.obs;
  RxString addressErrorMessage = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    uid = await FirebaseServices.checkUserUid();
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

  void handleBack() {
    Get.back();
  }

  void validateName() {
    if (name.text.isEmpty) {
      nameHasError.value = true;
      nameErrorMessage.value = 'Name is Required';
    } else {
      nameHasError.value = false;
      nameErrorMessage.value = '';
    }
  }

  void validateSurName() {
    if (surName.text.isEmpty) {
      surNameHasError.value = true;
      surNameErrorMessage.value = 'Surname is Required';
    } else {
      surNameHasError.value = false;
      surNameErrorMessage.value = '';
    }
  }

  void validateEmail() {
    if (email.text.isEmpty) {
      emailHasError.value = true;
      emailErrorMessage.value = 'Email is Required';
    } else if (!email.text.isEmail) {
      emailHasError.value = true;
      emailErrorMessage.value = 'Email is not valid';
    } else {
      emailHasError.value = false;
      emailErrorMessage.value = '';
    }
  }

  void validatePhone() {
    if (phone.text.isEmpty) {
      phoneHasError.value = true;
      phoneErrorMessage.value = 'Phone is Required';
    } else {
      phoneHasError.value = false;
      phoneErrorMessage.value = '';
    }
  }

  void validateAddress() {
    if (address.text.isEmpty) {
      addressHasError.value = true;
      addressErrorMessage.value = 'Address is Required';
    } else {
      addressHasError.value = false;
      addressErrorMessage.value = '';
    }
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
      var data = await FirebaseServices.getDataWhere(
          collection: 'clients', key: 'user_id', value: uid);
      currentClient.value = Client.fromJson(data!);
    } on Exception catch (ex) {
      log(ex.toString());
    }
  }

  void deleteUser() async {
    await FirebaseFirestore.instance
        .collection('appointments')
        .where('client_id', isEqualTo: uid)
        .get()
        .then((event) async {
      for (var element in event.docs) {
        await FirebaseFirestore.instance
            .collection('appointments')
            .doc(element.id)
            .delete();
      }
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogedIn', false);
    await LoginController.instance.auth.signOut();
    Get.offAll(LoginScreen());
  }
}
