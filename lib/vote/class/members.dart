import 'package:titan/admin/class/account_type.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/user/class/simple_users.dart';

class Member extends SimpleUser {
  late String role;

  Member({
    required super.name,
    required super.firstname,
    required super.nickname,
    required super.id,
    required super.accountType,
    required this.role,
  });

  @override
  Member copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    AccountType? accountType,
    String? role,
  }) {
    return Member(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname ?? this.nickname,
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      role: role ?? this.role,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'user_id': super.id, 'role': role};
  }

  factory Member.fromJson(Map<String, dynamic> map) {
    final user = map['user'];
    return Member(
      name: capitaliseAll(user['name']),
      firstname: capitaliseAll(user['firstname']),
      nickname: (user['nickname'] != "" && user['nickname'] != null)
          ? capitaliseAll(user['nickname'])
          : null,
      id: user['id'],
      accountType: AccountType(type: user['account_type']),
      role: capitaliseAll(map['role']),
    );
  }

  factory Member.fromSimpleUser(SimpleUser user, String role) {
    return Member(
      name: user.name,
      firstname: user.firstname,
      nickname: user.nickname,
      id: user.id,
      accountType: user.accountType,
      role: role,
    );
  }

  factory Member.empty() {
    return Member(
      name: '',
      firstname: '',
      nickname: '',
      id: '',
      accountType: AccountType.empty(),
      role: '',
    );
  }

  @override
  String toString() {
    return 'Member{id: $id, name: $name, firstname: $firstname, nickname: $nickname, role: $role}';
  }
}
