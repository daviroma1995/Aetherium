class MembershipType {
  String? id;
  String? name;
  String? icon;
  String? desc;
  int? discountRate;

  MembershipType({this.id, this.name, this.icon, this.desc, this.discountRate});

  MembershipType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    desc = json['desc'];
    discountRate = json['discount_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['desc'] = this.desc;
    data['discount_rate'] = this.discountRate;
    return data;
  }
}
