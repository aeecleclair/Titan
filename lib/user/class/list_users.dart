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
    name = json['name'];
    firstname = json['firstname'];
    nickname = json['nickname'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _users = <String, dynamic>{};
    _users['name'] = name;
    _users['firstname'] = firstname;
    _users['nickname'] = nickname;
    _users['id'] = id;
    return _users;
  }

  SimpleUser.empty()
      : name = '',
        firstname = '',
        nickname = '',
        id = '';

  String getName() {
    if (nickname.isNotEmpty) {
      return nickname + ' (' + firstname + ' ' + name + ')';
    } else {
      return firstname + ' ' + name;
    }
  }
}
