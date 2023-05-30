class Timeslot {
  String? startTime;
  String? endTime;
  List<String>? employeeIdList;
  List<String>? roomIdList;

  Timeslot(
      {this.startTime, this.endTime, this.employeeIdList, this.roomIdList});

  Timeslot.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    employeeIdList = json['employee_id_list'].cast<String>();
    roomIdList = json['room_id_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['employee_id_list'] = employeeIdList;
    data['room_id_list'] = roomIdList;
    return data;
  }
}
