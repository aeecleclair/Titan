import 'package:myecl/admin/class/association_membership_simple.dart';
import 'package:myecl/user/class/simple_users.dart';

class Structure {
  final String name;
  final AssociationMembership? associationMembership;
  final String id;
  final SimpleUser managerUser;

  Structure({
    required this.name,
    this.associationMembership,
    required this.id,
    required this.managerUser,
  });

  factory Structure.fromJson(Map<String, dynamic> json) {
    return Structure(
      name: json['name'],
      associationMembership: json['association_membership'] != null
          ? AssociationMembership.fromJson(json['association_membership'])
          : AssociationMembership.empty(),
      id: json['id'],
      managerUser: SimpleUser.fromJson(json['manager_user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'association_membership':
          associationMembership ?? AssociationMembership.empty(),
      'id': id,
      'manager_user_id': managerUser.id,
    };
  }

  @override
  String toString() {
    return 'Structure{name: $name, associationMembership: $associationMembership, id: $id, managerUserId: $managerUser}';
  }

  Structure copyWith({
    String? name,
    AssociationMembership? associationMembership,
    String? id,
    SimpleUser? managerUser,
  }) {
    return Structure(
      name: name ?? this.name,
      associationMembership:
          associationMembership ?? this.associationMembership,
      id: id ?? this.id,
      managerUser: managerUser ?? this.managerUser,
    );
  }

  Structure.empty()
      : this(
          name: '',
          associationMembership: AssociationMembership.empty(),
          id: '',
          managerUser: SimpleUser.empty(),
        );
}
