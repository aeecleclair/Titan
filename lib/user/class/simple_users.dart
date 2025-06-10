import 'package:titan/admin/class/account_type.dart';
import 'package:titan/tools/functions.dart';

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
  late final AccountType accountType;

  SimpleUser.fromJson(Map<String, dynamic> json) {
    name = capitaliseAll(json['name']);
    firstname = capitaliseAll(json['firstname']);
    nickname = (json['nickname'] != "" && json['nickname'] != null)
        ? capitaliseAll(json['nickname'])
        : null;
    id = json['id'];
    accountType = AccountType(type: json['account_type']);
  }

  Map<String, dynamic> toJson() {
    final users = <String, dynamic>{};
    users['name'] = name;
    users['firstname'] = firstname;
    users['nickname'] = nickname;
    users['id'] = id;
    users['account_type'] = accountType.type;
    return users;
  }

  SimpleUser.empty()
    : name = 'Nom',
      firstname = 'Prénom',
      nickname = null,
      id = '',
      accountType = AccountType.empty();

  String getName() {
    if (nickname == null) {
      return '$firstname $name';
    }
    return '$nickname ($firstname $name)';
  }

  @override
  String toString() {
    return "SimpleUser {name: $name, firstname: $firstname, nickname: $nickname, id: $id, accountType: ${accountType.type}}";
  }

  SimpleUser copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    AccountType? accountType,
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
