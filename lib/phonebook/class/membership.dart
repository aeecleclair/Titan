import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/role.dart';

class Membership{
  Membership({
    required this.association,
    required this.role,
  });

  late final Association association;
  late final Role role;

  Membership.fromJSON(Map<String, dynamic> json){
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

  Membership copyWith({
    Association? association,
    Role? role,
  }) {
    return Membership(
      association: association ?? this.association,
      role: role ?? this.role,
    );
  }

  Membership.empty(){
    association = Association.empty();
    role = Role.empty();
  }

  Membership setAssociation(String name, String id) {
    return copyWith(association: association.copyWith(name: name, id: id));
  }

  Membership setRole(String name, String id) {
    return copyWith(role: role.copyWith(name: name, id: id));
  }
}