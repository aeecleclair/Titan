import 'package:myecl/tools/functions.dart';

class CreateAccount {
  late String name;
  late String firstname;
  late String? nickname;
  late String password;
  late DateTime birthday;
  late String? phone;
  late String floor;
  late int? promo;
  late String activationToken;

  CreateAccount({
    required this.name,
    required this.firstname,
    required this.nickname,
    required this.password,
    required this.birthday,
    required this.phone,
    required this.floor,
    required this.promo,
    required this.activationToken,
  });

  CreateAccount.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    firstname = json['firstname'] as String;
    nickname = json['nickname'] as String;
    password = json['password'] as String;
    birthday = DateTime.parse(json['birthday'] as String);
    phone = json['phone'] != "" ? json['phone'] as String : null;
    floor = json['floor'] as String;
    promo = json['promo'] as int;
    activationToken = json['activation_token'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['firstname'] = firstname;
    data['nickname'] = nickname;
    data['password'] = password;
    data['birthday'] = processDateToAPIWithoutHour(birthday);
    data['phone'] = phone;
    data['floor'] = floor;
    data['promo'] = promo;
    data['activation_token'] = activationToken;
    return data;
  }

  CreateAccount.empty() {
    name = "";
    firstname = "";
    nickname = "";
    password = "";
    birthday = DateTime.now();
    phone = "";
    floor = "";
    activationToken = "";
  }

  CreateAccount copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? password,
    DateTime? birthday,
    String? phone,
    int? promo,
    String? floor,
    String? activationToken,
  }) {
    return CreateAccount(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      password: password ?? this.password,
      birthday: birthday ?? this.birthday,
      phone: phone ?? this.phone,
      floor: floor ?? this.floor,
      promo: promo,
      activationToken: activationToken ?? this.activationToken,
    );
  }

  @override
  String toString() {
    return "CreateAccount {name: $name, firstname: $firstname, nickname: $nickname, password: $password, birthday: $birthday, phone: $phone, promo: $promo, floor: $floor, activationToken: $activationToken}";
  }
}
