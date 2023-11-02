class AppointmentStatus {
  String? id;
  String? label;

  AppointmentStatus({this.id, this.label});

  AppointmentStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    return data;
  }
}
