import 'package:get/get.dart';

class TreatmentCategory {
  String? id;
  String? name;
  String? iconUrl;
  String? darkIconUrl;
  RxBool isExtended = false.obs;
  TreatmentCategory({this.id, this.name, this.iconUrl});

  TreatmentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrl = json['icon'];
    darkIconUrl = json['dark_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = iconUrl;
    data['dark_icon'] = darkIconUrl;
    return data;
  }

  @override
  String toString() {
    return 'ID: $id,\nName $name,\n';
  }
}
