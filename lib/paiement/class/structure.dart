import 'package:myecl/user/class/list_users.dart';

// ignore: constant_identifier_names
enum AvailableAssociationMembership { AEECL, USEECL, noMembership }

class Structure {
  final String name;
  final AvailableAssociationMembership membership;
  final String id;
  final SimpleUser managerUser;

  Structure({
    required this.name,
    required this.membership,
    required this.id,
    required this.managerUser,
  });

  factory Structure.fromJson(Map<String, dynamic> json) {
    return Structure(
      name: json['name'],
      membership: json['membership'] != null
          ? AvailableAssociationMembership.values.firstWhere(
              (e) => e.toString().split('.').last == json['membership'],
            )
          : AvailableAssociationMembership.noMembership,
      id: json['id'],
      managerUser: SimpleUser.fromJson(json['manager_user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'membership': membership == AvailableAssociationMembership.noMembership
          ? null
          : membership.toString().split('.').last,
      'id': id,
      'manager_user_id': managerUser.id,
    };
  }

  @override
  String toString() {
    return 'Structure{name: $name, membership: $membership, id: $id, managerUserId: $managerUser}';
  }

  Structure copyWith({
    String? name,
    AvailableAssociationMembership? membership,
    String? id,
    SimpleUser? managerUser,
  }) {
    return Structure(
      name: name ?? this.name,
      membership: membership ?? this.membership,
      id: id ?? this.id,
      managerUser: managerUser ?? this.managerUser,
    );
  }

  Structure.empty()
      : this(
          name: '',
          membership: AvailableAssociationMembership.noMembership,
          id: '',
          managerUser: SimpleUser.empty(),
        );
}
