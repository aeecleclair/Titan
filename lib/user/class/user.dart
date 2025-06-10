import 'package:titan/admin/class/account_type.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/user/class/applicant.dart';
import 'package:titan/user/class/simple_users.dart';
import 'package:titan/user/class/floors.dart';

class User {
  User({
    required this.name,
    required this.firstname,
    required this.nickname,
    required this.id,
    required this.email,
    required this.accountType,
    required this.birthday,
    required this.promo,
    required this.floor,
    required this.phone,
    required this.createdOn,
    required this.groups,
  });
  late final String name;
  late final String firstname;
  late final String? nickname;
  late final String id;
  late final String email;
  late final AccountType accountType;
  late final DateTime? birthday;
  late final int? promo;
  late final String? floor;
  late final String? phone;
  late final DateTime createdOn;
  late final List<SimpleGroup> groups;

  User.fromJson(Map<String, dynamic> json) {
    name = capitaliseAll(json['name']);
    firstname = capitaliseAll(json['firstname']);
    nickname = (json['nickname'] != "" && json['nickname'] != null)
        ? capitaliseAll(json['nickname'])
        : null;
    id = json['id'];
    email = json['email'];
    accountType = AccountType(type: json['account_type']);
    birthday = json['birthday'] != null
        ? processDateFromAPIWithoutHour(json['birthday'])
        : null;
    promo = json['promo'];
    floor =
        json['floor'] ??
        capitalize(Floors.values.first.toString().split('.').last);
    phone = (json['phone'] != "" && json["phone"] != null)
        ? json['phone']
        : null;
    createdOn = processDateFromAPI(json['created_on']);
    groups = List.from(
      json['groups'],
    ).map((e) => SimpleGroup.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['firstname'] = firstname;
    data['nickname'] = nickname;
    data['id'] = id;
    data['email'] = email;
    data['account_type'] = accountType.type;
    data['birthday'] = birthday != null
        ? processDateToAPIWithoutHour(birthday!)
        : null;
    data['promo'] = promo;
    data['floor'] = floor;
    data['phone'] = phone;
    data['created_on'] = processDateToAPI(createdOn);
    data['groups'] = groups.map((e) => e.toJson()).toList();
    return data;
  }

  User.empty() {
    name = 'Nom';
    firstname = 'Prénom';
    nickname = null;
    id = '';
    email = 'empty@ecl.ec-lyon.fr';
    accountType = AccountType.empty();
    birthday = normalizedDate(DateTime.now());
    promo = null;
    floor = capitalize(Floors.values.first.toString().split('.').last);
    phone = null;
    createdOn = DateTime.now();
    groups = [];
  }

  User copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    String? email,
    AccountType? accountType,
    DateTime? birthday,
    int? promo,
    String? floor,
    String? phone,
    DateTime? createdOn,
    List<SimpleGroup>? groups,
  }) {
    return User(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname,
      id: id ?? this.id,
      email: email ?? this.email,
      accountType: accountType ?? this.accountType,
      birthday: birthday ?? this.birthday,
      promo: promo,
      floor: floor ?? this.floor,
      phone: phone,
      createdOn: createdOn ?? this.createdOn,
      groups: groups ?? this.groups,
    );
  }

  SimpleUser toSimpleUser() {
    return SimpleUser(
      name: name,
      firstname: firstname,
      nickname: nickname,
      id: id,
      accountType: accountType,
    );
  }

  String getName() {
    if (nickname == null) {
      return '$firstname $name';
    }
    return '$nickname ($firstname $name)';
  }

  @override
  String toString() {
    return "User {name: $name, firstname: $firstname, nickname: $nickname, id: $id, email: $email, accountType: ${accountType.type}, birthday: $birthday, promo: $promo, floor: $floor, phone: $phone, createdOn: $createdOn, groups: $groups}";
  }

  Applicant toApplicant() {
    return Applicant(
      name: name,
      firstname: firstname,
      nickname: nickname,
      id: id,
      accountType: accountType,
      email: email,
      promo: promo,
      phone: '',
    );
  }
}
