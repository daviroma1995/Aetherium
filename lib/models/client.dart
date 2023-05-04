class Client {
  String? id;
  String? firstName;
  String? lastName;
  String? gender;
  String? phoneNumber;
  String? email;
  String? address;
  String? photo;
  String? userId;
  bool? isAdmin;

  Client(
      {this.id,
      this.firstName,
      this.lastName,
      this.gender,
      this.phoneNumber,
      this.email,
      this.address,
      this.photo,
      this.userId,
      this.isAdmin});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    address = json['address'];
    photo = json['photo'];
    userId = json['user_id'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['address'] = this.address;
    data['photo'] = this.photo;
    data['user_id'] = this.userId;
    return data;
  }
}
