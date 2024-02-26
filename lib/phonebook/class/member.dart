import 'package:myecl/user/class/list_users.dart';

class Member {
  Member({
    required this.name,
    required this.firstname,
    required this.nickname,
    required this.id,
    required this.email,
    required this.promotion,
  });

  late final String name;
  late final String firstname;
  late final String? nickname;
  late final String id;
  late final String email;
  late final String promotion;

  Member.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firstname = json['firstname'];
    nickname = json['nickname'];
    id = json['id'];
    email = json['email'];
    promotion = json['promotion'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'name': name,
      'firstname': firstname,
      'nickname': nickname,
      'id': id,
      'email': email,
      'promotion': promotion,
    };
    return data;
  }

  Member copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    String? email,
    String? promotion,
  }) {
    return Member(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname,
      id: id ?? this.id,
      email: email ?? this.email,
      promotion: promotion ?? this.promotion,
    );
  }

  Member.empty() {
    name = "nom";
    firstname = "prénom";
    nickname = null;
    id = "";
    email = "email.test@empty.useless";
    promotion = "Exx";
  }

  Member.fromUser(SimpleUser user) {
    name = user.name;
    firstname = user.firstname;
    nickname = user.nickname;
    id = user.id;
    email = "";
    promotion = "Exx";
  }

  @override
  String toString() {
    return 'Member(name: $name, firstname: $firstname, nickname: $nickname, id: $id, email: $email, promotion: $promotion)';
  }

  String getName() {
    return "$firstname $name ($nickname)";
  }
}
