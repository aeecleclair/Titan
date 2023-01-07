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
  late final String nickname;
  late final String id;

  SimpleUser.fromJson(Map<String, dynamic> json) {
    name = capitaliseAll(json['name']);
    firstname = capitaliseAll(json['firstname']);
    nickname = capitaliseAll(json['nickname'] ?? "");
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
        nickname = '',
        id = '';

  String getName() {
    if (nickname.isNotEmpty && !["-", "/", " "].contains(nickname)) {
      return '$nickname ($firstname $name)';
    } else {
      return '$firstname $name';
    }
  }
}
