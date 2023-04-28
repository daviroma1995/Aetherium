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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['desc'] = desc;
    data['discount_rate'] = discountRate;
    return data;
  }
}
