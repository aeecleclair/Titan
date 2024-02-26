import 'package:myecl/user/class/list_users.dart';

class Member extends SimpleUser {
  Member({
    required super.name,
    required super.firstname,
    required super.nickname,
    required super.id,
    required this.email,
    required this.promotion,
  });
  late final String email;
  late final String promotion;

  Member.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    email = json['email'];
    promotion = json['promotion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['email'] = email;
    data['promotion'] = promotion;
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

  Member.empty() : super.empty() {
    email = "email.test@empty.useless";
    promotion = "Exx";
  }

  Member.fromUser(SimpleUser user) : super.empty() {
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
}
