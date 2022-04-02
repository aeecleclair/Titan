class User {
  String? id;
  String? type;
  String? name;
  String? firstname;
  String? nickname;
  String? email;
  DateTime? birthday;
  String? phone;
  String? floor;
  List<String>? associations;

  User(
      {this.id,
      this.type,
      this.name,
      this.firstname,
      this.nickname,
      this.email,
      this.birthday,
      this.phone,
      this.floor,
      this.associations});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    firstname = json['firstname'];
    nickname = json['nickname'];
    email = json['email'];
    if (json['birthday'] != null) {
      birthday = DateTime.parse(json['birthday']);
    } else {
      birthday = null;
    }
    phone = json['phone'];
    floor = json['floor'];
    associations = json['associations'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['firstname'] = firstname;
    data['nickname'] = nickname;
    data['email'] = email;
    data['birthday'] = birthday.toString();
    data['phone'] = phone;
    data['floor'] = floor;
    data['associations'] = associations;
    return data;
  }
}
