import 'dart:convert';
import 'dart:developer';

import 'package:atherium_saloon_app/models/membership_type.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/utils/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/client.dart';
import '../../models/membership.dart';
import '../new_client_confirm_screen/new_client_confirm_screen.dart';

class AddNewClientController extends GetxController {
  String uid = '';
  final String _apiLink =
      'https://us-central1-aetherium-salon.cloudfunctions.net/createUserwithEmail';
  var currentClient = Client().obs;
  TextEditingController name = TextEditingController();
  TextEditingController surName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool nameHasError = false.obs;
  RxBool surNameHasError = false.obs;
  RxBool emailHasError = false.obs;
  RxBool phoneHasError = false.obs;
  RxBool addressHasError = false.obs;
  RxBool passwordHasError = false.obs;
  RxBool isLoading = false.obs;
  RxString nameErrorMessage = ''.obs;
  RxString surNameErrorMessage = ''.obs;
  RxString emailErrorMessage = ''.obs;
  RxString phoneErrorMessage = ''.obs;
  RxString addressErrorMessage = ''.obs;
  RxString passwordErrorMessage = ''.obs;
  RxString loyaltyPoints = '0'.obs;
  RxString selectedMembership = ''.obs;

  List<MembershipType> membershipTypes = [];
  RxList<String> membershipTypesNames = <String>[].obs;
  RxList<String> membershipTypeIds = <String>[].obs;

  List<String> loyaltyPointsList = [
    "0",
    "25",
    "50",
    "75",
    "100",
    "125",
    "150",
    "175",
    "200",
    "225",
    "250",
    "275",
    "300"
  ];

  @override
  void onReady() async {
    super.onReady();
    imageFileString.value = LocalData.imageUrlString;
  }

  @override
  void onInit() {
    super.onInit();
    loadMembershipTypes();
  }

  RxString genderValue = tr('gender').obs;
  RxBool isUpdating = false.obs;
  RxString imageFileString = ''.obs;
  final dateOfBirth = DateTime.now().obs;

  String get getDateOfBirth {
    if (dateOfBirth.value.day == DateTime.now().day &&
        dateOfBirth.value.month == DateTime.now().month &&
        dateOfBirth.value.year == DateTime.now().year) {
      return tr('date');
    }
    final day = dateOfBirth.value.day < 10
        ? '0${dateOfBirth.value.day}'
        : dateOfBirth.value.day.toString();
    final month = dateOfBirth.value.month < 10
        ? '0${dateOfBirth.value.month}'
        : dateOfBirth.value.month.toString();
    return '$day/$month/${dateOfBirth.value.year}';
  }

  void changeLoyaltyPointsValue(String value) {
    loyaltyPoints.value = value;
  }

  void changeValue(String value) {
    genderValue.value = value;
  }

  void changeMembershipTypeValue(String value) {
    selectedMembership.value = value;
  }

  void handleBack() {
    Get.back();
  }

  void validateName() {
    if (name.text.isEmpty) {
      nameHasError.value = true;
      nameErrorMessage.value = tr('name_is_required');
    } else {
      nameHasError.value = false;
      nameErrorMessage.value = '';
    }
  }

  void validateSurName() {
    if (surName.text.isEmpty) {
      surNameHasError.value = true;
      surNameErrorMessage.value = tr('surname_is_required');
    } else {
      surNameHasError.value = false;
      surNameErrorMessage.value = '';
    }
  }

  void validateEmail() {
    if (email.text.isEmpty) {
      emailHasError.value = true;
      emailErrorMessage.value = tr('email_is_required');
    } else if (!email.text.isEmail) {
      emailHasError.value = true;
      emailErrorMessage.value = tr('email_is_not_valid');
    } else {
      emailHasError.value = false;
      emailErrorMessage.value = '';
    }
  }

  void validatePhone() {
    if (phone.text.isEmpty) {
      phoneHasError.value = true;
      phoneErrorMessage.value = tr('number_is_required');
    } else if (phone.text.length < 6) {
      phoneHasError.value = true;
      phoneErrorMessage.value = tr('not_a_valid_number');
    } else {
      phoneHasError.value = false;
      phoneErrorMessage.value = '';
    }
  }

  void validatePassword() {
    if (password.text.length < 6) {
      passwordHasError.value = true;
      passwordErrorMessage.value = tr('password_must_be_8_characters_long');
    } else {
      passwordHasError.value = false;
      passwordErrorMessage.value = '';
    }
  }

  void validateAddress() {
    if (address.text.isEmpty) {
      addressHasError.value = true;
      addressErrorMessage.value = tr('address_is_required');
    } else {
      addressHasError.value = false;
      addressErrorMessage.value = '';
    }
  }

  void validateAndSave() async {
    isLoading.value = true;
    validateName();
    validateSurName();
    validateEmail();
    validatePhone();
    validateAddress();
    if (nameHasError.value == false &&
        surNameHasError.value == false &&
        emailHasError.value == false &&
        phoneHasError.value == false &&
        addressHasError.value == false) {
      String? uid;
      // try {
      // await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(
      //         email: email.text, password: '12312sddfuuDD#')
      //     .then((value) async {
      //   await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);

      // uid = value.user!.uid;
      var client = http.Client();
      try {
        var url = Uri.parse(_apiLink);
        await client.post(url, body: {
          'email': email.text,
          'password': password.text.isNotEmpty && password.text.length >= 6
              ? password.text
              : '123456aetherium'
        }).then((value) async {
          if (value.statusCode == 200) {
            var data = value.body;
            var json = jsonDecode(data);
            if (password.text.isEmpty) {
              await FirebaseAuth.instance
                  .sendPasswordResetEmail(email: json['email']);
            }

            uid = json['uid'];
            Timestamp birthday = Timestamp.fromDate(dateOfBirth.value);
            String today = DateFormat("dd/MM/yyyy").format(DateTime.now());
            var clientData = Client(
                firstName: name.text,
                lastName: surName.text,
                email: email.text,
                phoneNumber: phone.text,
                gender: genderValue.value,
                isAdmin: false,
                address: address.text,
                birthday: birthday,
                photo: '',
                userId: uid,
                password: password.text);

            Membership membership = Membership(
                clientId: uid,
                membershipTypeId: getMembershipId(),
                points: int.parse(loyaltyPoints.value),
                startDate: today);
            if (uid != null) {
              await FirebaseFirestore.instance
                  .collection('clients')
                  .doc(uid)
                  .set(clientData.toJson())
                  .then((value) async {
                await FirebaseFirestore.instance
                    .collection('client_memberships')
                    .doc(uid)
                    .set(membership.toJson());
              });
            }
            Fluttertoast.showToast(
                msg: tr('client_creating_message_I'),
                backgroundColor: AppColors.GREEN_COLOR);
            Get.to(() => const NewClientConfirmScreen());
          } else if (value.statusCode == 500) {
            var data = value.body;
            var json = jsonDecode(data);
            if (json['code'] == 'auth/email-already-exists') {
              Fluttertoast.showToast(msg: tr('email_already_in_use'));
            }
          }
        });
      } catch (err) {
        log(err.toString());
      }
    }
    isLoading.value = false;
  }

  Future<void> loadMembershipTypes() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('membership_type').get();
    // membershipTypes

    membershipTypesNames.value =
        querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    membershipTypeIds.value =
        querySnapshot.docs.map((doc) => doc['id'] as String).toList();

    if (membershipTypesNames.isNotEmpty) {
      selectedMembership.value = membershipTypesNames[0];
    }
    update();
  }

  String getMembershipId() {
    int index = membershipTypesNames.indexOf(selectedMembership.value);
    return membershipTypeIds[index];
  }
}
