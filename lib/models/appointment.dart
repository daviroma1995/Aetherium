class Appointment {
  String? id;
  String? date;
  String? time;
  String? number;
  String? email;
  String? notes;
  String? employeeId;
  String? serviceId;
  String? clientId;
  String? statusId;

  Appointment(
      {this.id,
      this.date,
      this.time,
      this.number,
      this.email,
      this.notes,
      this.employeeId,
      this.serviceId,
      this.clientId,
      this.statusId});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    number = json['number'];
    email = json['email'];
    notes = json['notes'];
    employeeId = json['employee_id'];
    serviceId = json['service_id'];
    clientId = json['client_id'];
    statusId = json['status_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['number'] = this.number;
    data['email'] = this.email;
    data['notes'] = this.notes;
    data['employee_id'] = this.employeeId;
    data['service_id'] = this.serviceId;
    data['client_id'] = this.clientId;
    data['status_id'] = this.statusId;
    return data;
  }
}
