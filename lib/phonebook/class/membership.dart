class Membership {
  Membership({
    required this.id,
    required this.associationId,
    required this.rolesTags,
    required this.apparentName,
  });

  late final String id;
  late final String associationId;
  late final List<String> rolesTags;
  late final String apparentName;

  Membership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    associationId = json['association_id'];
    rolesTags = json['role_tags'].split(";");
    apparentName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'association': associationId,
      'role_tags': rolesTags.join(";"),
      'role_name': apparentName,
    };
    return data;
  }

  Membership copyWith({
    String? id,
    String? associationId,
    List<String>? rolesTags,
    String? apparentName,
  }) {
    return Membership(
      id: id ?? this.id,
      associationId: associationId ?? this.associationId,
      rolesTags: rolesTags ?? this.rolesTags,
      apparentName: apparentName ?? this.apparentName,
    );
  }

  Membership.empty() {
    id = "";
    associationId = "";
    rolesTags = [];
    apparentName = "";
  }

  Membership setAssociation(String id) {
    return copyWith(associationId: id);
  }

  Membership setRolesTags(List<String> rolesTags) {
    return copyWith(rolesTags: rolesTags);
  }

  Membership setApparentName(String apparentName) {
    return copyWith(apparentName: apparentName);
  }

  @override
  String toString() {
    return 'Membership(id: $id, association: $associationId, rolesTags: ${rolesTags.join(";")}, apparentName: $apparentName)';
  }
}
