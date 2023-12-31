import 'package:easy_localization/easy_localization.dart';

class Membership {
  String? id;
  String? startDate;
  int? points;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['points'] = points;
    data['client_id'] = clientId;
    data['membership_type_id'] = membershipTypeId;
    return data;
  }

  double get percentage {
    return points! / 300;
  }

  String getEndDate() {
    String date = '';
    var inputFormat = DateFormat('dd/MM/yyyy');
    var startDateTime = inputFormat.parse(startDate ?? '01/01/2000');

    DateTime endDate = DateTime(
        startDateTime.year + 1, startDateTime.month, startDateTime.day);
    date = DateFormat('dd/MM/yyyy').format(endDate);
    return date;
  }
}
