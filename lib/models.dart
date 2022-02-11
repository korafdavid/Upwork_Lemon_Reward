class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? username;
  String? profilephoto;
  int? iV;



  User(
      {this.sId,
      this.firstName,
      this.lastName,
      this.username,
      this.profilephoto,
      this.iV,
      });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    profilephoto = json['profilephoto'];
    iV = json['__v'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;

    data['profilephoto'] = profilephoto;
    data['__v'] = iV;
    return data;
  }
}