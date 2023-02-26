import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/role.dart';

class Post{
  Post({
    required this.association,
    required this.role,
  });

  late final Association association;
  late final Role role;

  Post.fromJSON(Map<String, dynamic> json){
      association = json['association'];
      role = json['role'];
      }
  
  Map<String, dynamic> toJSON(){
    final data = <String, dynamic>{
      'association': association.id,
      'role': role.id,
    };
    return data;
  }

  Post copyWith({
    Association? association,
    Role? role,
  }) {
    return Post(
      association: association ?? this.association,
      role: role ?? this.role,
    );
  }

  Post.empty(){
    association = Association.empty();
    role = Role.empty();
  }

  Post setAssociation(String name, String id) {
    return copyWith(association: association.copyWith(name: name, id: id));
  }

  Post setRole(String name, String id) {
    return copyWith(role: role.copyWith(name: name, id: id));
  }
}