class Employee {
  String? id;
  String? name;
  List<String>? serviceList;

  Employee({this.id, this.name, this.serviceList});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceList = json['treatment_id_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['treatment_id_list'] = serviceList;
    return data;
  }
}
