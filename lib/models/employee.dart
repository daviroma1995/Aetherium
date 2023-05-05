class Employee {
  String? id;
  String? name;
  List<String>? serviceList;

  Employee({this.id, this.name, this.serviceList});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceList = json['service_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['service_list'] = this.serviceList;
    return data;
  }
}
