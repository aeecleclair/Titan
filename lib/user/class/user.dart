import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/class/applicant.dart';
import 'package:myecl/user/class/list_users.dart';

class User {
  User({
    required this.name,
    required this.firstname,
    required this.nickname,
    required this.id,
    required this.email,
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
  late final String birthday;
  late final int promo;
  late final String floor;
  late final String? phone;
  late final String createdOn;
  late final List<SimpleGroup> groups;

  User.fromJson(Map<String, dynamic> json) {
    name = capitaliseAll(json['name']);
    firstname = capitaliseAll(json['firstname']);
    nickname = json['nickname'] != "" ? capitaliseAll(json['nickname']) : null;
    id = json['id'];
    email = json['email'];
    birthday = json['birthday'];
    promo = json['promo'];
    floor = json['floor'];
    phone = json['phone'] != "" ? json['phone'] : null;
    createdOn = json['created_on'];
    groups =
        List.from(json['groups']).map((e) => SimpleGroup.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['firstname'] = firstname;
    data['nickname'] = nickname;
    data['id'] = id;
    data['email'] = email;
    data['birthday'] = birthday;
    data['promo'] = promo;
    data['floor'] = floor;
    data['phone'] = phone;
    data['created_on'] = createdOn;
    data['groups'] = groups.map((e) => e.toJson()).toList();
    return data;
  }

  User.empty() {
    name = 'Nom';
    firstname = 'Prénom';
    nickname = null;
    id = '';
    email = 'empty@ecl.ec-lyon.fr';
    birthday = DateTime.now().toIso8601String().split("T")[0];
    promo = 22;
    floor = 'W1';
    phone = null;
    createdOn = '';
    groups = [];
  }

  User copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    String? email,
    String? birthday,
    int? promo,
    String? floor,
    String? phone,
    String? createdOn,
    List<SimpleGroup>? groups,
  }) {
    return User(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      promo: promo ?? this.promo,
      floor: floor ?? this.floor,
      phone: phone ?? this.phone,
      createdOn: createdOn ?? this.createdOn,
      groups: groups ?? this.groups,
    );
  }

  SimpleUser toSimpleUser() {
    return SimpleUser(
        name: name, firstname: firstname, nickname: nickname, id: id);
  }

  @override
  String toString() {
    return "User {name: $name, firstname: $firstname, nickname: $nickname, id: $id, email: $email, birthday: $birthday, promo: $promo, floor: $floor, phone: $phone, createdOn: $createdOn, groups: $groups}";
  }
  
  Applicant toApplicant() {
    return Applicant(
        name: name,
        firstname: firstname,
        nickname: nickname,
        id: id,
        email: email,
        promo: promo,
        phone: '');
  }
}
