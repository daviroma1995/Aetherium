import 'package:get/get.dart';

class TreatmentCategory {
  String? id;
  String? name;
  String? description;
  RxBool isExtended = false.obs;
  TreatmentCategory({this.id, this.name, this.description});

  TreatmentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
