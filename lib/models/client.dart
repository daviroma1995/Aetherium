import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Client {
  String? id;
  String? firstName;
  String? lastName;
  String? gender;
  String? phoneNumber;
  String? email;
  String? address;
  String? photo;
  String? userId;
  bool? isAdmin;
  Timestamp? birthday;

  Client(
      {this.id,
      this.firstName,
      this.lastName,
      this.gender,
      this.phoneNumber,
      this.email,
      this.address,
      this.photo,
      this.userId,
      this.isAdmin,
      this.birthday});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    address = json['address'];
    photo = json['photo'];
    userId = json['user_id'];
    isAdmin = json['isAdmin'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['photo'] = photo;
    data['user_id'] = userId;
    data['birthday'] = birthday;
    data['isAdmin'] = isAdmin;
    return data;
  }

  String getBirthday() {
    String date = '';
    date = DateFormat('dd/MM/yyyy').format(birthday!.toDate());
    return date;
  }

  String get fullName => '$firstName $lastName';
}
