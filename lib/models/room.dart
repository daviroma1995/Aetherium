class Room {
  String? id;
  String? description;
  List<String>? serviceList;

  Room({this.id, this.description, this.serviceList});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    serviceList = json['service_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['service_list'] = this.serviceList;
    return data;
  }
}
