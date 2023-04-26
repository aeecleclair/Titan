import 'package:myecl/user/class/list_users.dart';

class Member{
  Member({
    required this.name,
    required this.firstname,
    required this.nickname,
    required this.id,
    required this.email,
  });

  late final String name;
  late final String firstname;
  late final String? nickname;
  late final String id;
  late final String email;

  Member.fromJSON(Map<String, dynamic> json){
      name = json['name'];
      firstname = json['firstname'];
      nickname = json['nickname'];
      id = json['id'];
      email = json['email'];
      }
  
  Map<String, dynamic> toJSON(){
    final data = <String, dynamic>{
      'name': name,
      'firstname': firstname,
      'nickname': nickname,
      'id': id,
      'email': email,
    };
    return data;
  }

  Member copyWith({
    String? name,
    String? firstname,
    String? nickname,
    String? id,
    String? email,
  }) {
    return Member(
      name: name ?? this.name,
      firstname: firstname ?? this.firstname,
      nickname: nickname,
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }

  Member.empty(){
    name = "nom";
    firstname = "prénom";
    nickname = null;
    id = "";
    email = "email.test@empty.useless";
  }

  Member.fromUser(SimpleUser user){
    name = user.name;
    firstname = user.firstname;
    nickname = user.nickname;
    id = user.id;
    email = "";
  }

  @override
  String toString() {
    return 'Member(name: $name, firstname: $firstname, nickname: $nickname, id: $id, email: $email)';
  }
}