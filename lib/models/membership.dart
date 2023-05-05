class Membership {
  String? id;
  String? startDate;
  String? points;
  String? clientId;
  String? membershipTypeId;

  Membership(
      {this.id,
      this.startDate,
      this.points,
      this.clientId,
      this.membershipTypeId});

  Membership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    points = json['points'];
    clientId = json['client_id'];
    membershipTypeId = json['membership_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['points'] = this.points;
    data['client_id'] = this.clientId;
    data['membership_type_id'] = this.membershipTypeId;
    return data;
  }
}
