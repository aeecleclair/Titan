import 'package:myecl/groups/class/group.dart';

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
    required this.createdOn,
    required this.groups,
  });
  late final String name;
  late final String firstname;
  late final String nickname;
  late final String id;
  late final String email;
  late final String birthday;
  late final int promo;
  late final String floor;
  late final String createdOn;
  late final List<Group> groups;

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firstname = json['firstname'];
    nickname = json['nickname'];
    id = json['id'];
    email = json['email'];
    birthday = json['birthday'];
    promo = json['promo'];
    floor = json['floor'];
    createdOn = json['created_on'];
    groups = List.from(json['groups']).map((e) => Group.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['firstname'] = firstname;
    _data['nickname'] = nickname;
    _data['id'] = id;
    _data['email'] = email;
    _data['birthday'] = birthday;
    _data['promo'] = promo;
    _data['floor'] = floor;
    _data['created_on'] = createdOn;
    _data['groups'] = groups.map((e) => e.toJson()).toList();
    return _data;
  }

  User.empty() {
    name = 'Nom';
    firstname = 'Prénom';
    nickname = 'Surnom';
    id = '';
    email = '';
    birthday = '';
    promo = 0;
    floor = '';
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
    String? createdOn,
    List<Group>? groups,
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
      createdOn: createdOn ?? this.createdOn,
      groups: groups ?? this.groups,
    );
  }
}
