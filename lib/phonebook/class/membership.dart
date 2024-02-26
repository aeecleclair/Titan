import 'package:myecl/phonebook/class/association.dart';
import 'package:myecl/phonebook/class/roles_tags.dart';

class Membership{
  Membership({
    required this.association,
    required this.rolesTags,
    required this.apparentName,
  });

  late final Association association;
  late final List<String> rolesTags;
  late final String apparentName;

  Membership.fromJSON(Map<String, dynamic> json){
      association = json['association'];
      rolesTags = json['role'];
      apparentName = json['apparentName'];
      }
  
  Map<String, dynamic> toJSON(){
    final data = <String, dynamic>{
      'association': association.id,
      'rolesTags': rolesTags,
      'apparentName': apparentName,
    };
    return data;
  }

  Membership copyWith({
    Association? association,
    List<String>? rolesTags,
    String? apparentName,
  }) {
    return Membership(
      association: association ?? this.association,
      rolesTags: rolesTags ?? this.rolesTags,
      apparentName: apparentName ?? this.apparentName,
    );
  }

  Membership.empty(){
    association = Association.empty();
    rolesTags = [];
    apparentName = "";
  }

  Membership setAssociation(String name, String id) {
    return copyWith(association: association.copyWith(name: name, id: id));
  }

  Membership setRolesTags(List<String> rolesTags) {
    return copyWith(rolesTags: rolesTags);
  }

  Membership setApparentName(String apparentName) {
    return copyWith(apparentName: apparentName);
  }
}