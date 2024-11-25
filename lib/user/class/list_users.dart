import 'package:myecl/tools/functions.dart';

class SimpleUser {
  SimpleUser({
    required this.name,
    required this.firstname,
    required this.nickname,
    required this.id,
    required this.accountType,
  });
  late final String name;
  late final String firstname;
  late final String? nickname;
  late final String id;
  late final String accountType;

  SimpleUser.fromJson(Map<String, dynamic> json) {
    name = capitaliseAll(json['name']);
    firstname = capitaliseAll(json['firstname']);
    nickname = (json['nickname'] != "" && json['nickname'] != null)
        ? capitaliseAll(json['nickname'])
        : null;
    id = json['id'];
    accountType = json['account_type'];
  }

  Map<String, dynamic> toJson() {
    final users = <String, dynamic>{};
    users['name'] = name;
    users['firstname'] = firstname;
    users['nickname'] = nickname;
    users['id'] = id;
    users['account_type'] = accountType;
    return users;
  }

  SimpleUser.empty()
      : name = 'Nom',
        firstname = 'Prénom',
        nickname = null,
        id = '',
        accountType = 'external';

  String getName() {
    if (nickname == null) {
      return '$firstname $name';
    }
    return '$nickname ($firstname $name)';
  }

  @override
  String toString() {
    return "SimpleUser {name: $name, firstname: $firstname, nickname: $nickname, id: $id, accountType: $accountType}";
  }

  SimpleUser copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    String? accountType,
  }) {
    return SimpleUser(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
    );
  }
}
