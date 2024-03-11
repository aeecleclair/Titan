import 'package:myecl/tools/functions.dart';

class SimpleUser {
  SimpleUser({
    required this.name,
    required this.firstname,
    required this.nickname,
    required this.id,
  });
  late final String name;
  late final String firstname;
  late final String? nickname;
  late final String id;

  SimpleUser.fromJson(Map<String, dynamic> json) {
    name = capitaliseAll(json['name'] as String);
    firstname = capitaliseAll(json['firstname'] as String);
    nickname = (json['nickname'] != "" && json['nickname'] != null)
        ? capitaliseAll(json['nickname'] as String)
        : null;
    id = json['id'] as String;
  }

  Map<String, dynamic> toJson() {
    final users = <String, dynamic>{};
    users['name'] = name;
    users['firstname'] = firstname;
    users['nickname'] = nickname;
    users['id'] = id;
    return users;
  }

  SimpleUser.empty()
      : name = 'Nom',
        firstname = 'Prénom',
        nickname = null,
        id = '';

  String getName() {
    if (nickname == null) {
      return '$firstname $name';
    }
    return '$nickname ($firstname $name)';
  }

  @override
  String toString() {
    return "SimpleUser {name: $name, firstname: $firstname, nickname: $nickname, id: $id}";
  }

  SimpleUser copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
  }) {
    return SimpleUser(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
    );
  }
}
