class AssociationMembership {
  AssociationMembership({
    required this.id,
    required this.name,
    required this.managerGroupId,
    required this.templateId,
  });
  late final String id;
  late final String name;
  late final String managerGroupId;
  late final String? templateId;

  AssociationMembership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    managerGroupId = json['manager_group_id'];
    templateId = json['template_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['manager_group_id'] = managerGroupId;
    data['template_id'] = templateId;
    return data;
  }

  AssociationMembership copyWith({
    String? id,
    String? name,
    String? managerGroupId,
    String? templateId,
  }) => AssociationMembership(
    id: id ?? this.id,
    name: name ?? this.name,
    managerGroupId: managerGroupId ?? this.managerGroupId,
    templateId: templateId ?? this.templateId,
  );

  AssociationMembership.empty() {
    id = '';
    name = "Pas d'adhésion";
    managerGroupId = '';
    templateId = '';
  }

  @override
  String toString() {
    return 'AssociationMembership(id: $id, name: $name, groupId: $managerGroupId, templateId: $templateId)';
  }
}

class AssociationMembershipRenewDocumentsReturn {
  AssociationMembershipRenewDocumentsReturn({required this.errors});
  late final Map<String, String> errors;

  AssociationMembershipRenewDocumentsReturn.fromJson(
    Map<String, dynamic> json,
  ) {
    errors = Map<String, String>.from(json['errors'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errors'] = errors;
    return data;
  }

  @override
  String toString() {
    return 'AssociationMembershipRenewDocumentsReturn(errors: $errors)';
  }
}
