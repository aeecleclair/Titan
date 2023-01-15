import 'package:myecl/tools/functions.dart';

class CreateAccount {
  late String name;
  late String firstname;
  late String nickname;
  late String password;
  late DateTime birthday;
  late String phone;
  late String floor;
  late String activationToken;

  CreateAccount({
    required this.name,
    required this.firstname,
    required this.nickname,
    required this.password,
    required this.birthday,
    required this.phone,
    required this.floor,
    required this.activationToken,
  });

  CreateAccount.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firstname = json['firstname'];
    nickname = json['nickname'];
    password = json['password'];
    birthday = DateTime.parse(json['birthday']);
    phone = json['phone'];
    floor = json['floor'];
    activationToken = json['activation_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['firstname'] = firstname;
    data['nickname'] = nickname;
    data['password'] = password;
    data['birthday'] = processDateToAPIWitoutHour(birthday);
    data['phone'] = phone;
    data['floor'] = floor;
    data['activation_token'] = activationToken;
    return data;
  }

  CreateAccount copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? password,
    DateTime? birthday,
    String? phone,
    String? promo,
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
      activationToken: activationToken ?? this.activationToken,
    );
  }
}
