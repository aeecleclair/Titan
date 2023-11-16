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
    name = capitaliseAll(json['name']);
    firstname = capitaliseAll(json['firstname']);
    nickname = (json['nickname'] != "" && json['nickname'] != null)
        ? capitaliseAll(json['nickname'])
        : null;
    id = json['id'];
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
      : name = '',
        firstname = '',
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
}
