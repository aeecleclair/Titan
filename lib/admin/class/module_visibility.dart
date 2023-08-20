class ModuleVisibilities {
  ModuleVisibilities({
    required this.root,
    required this.allowedGroupIds,
  });
  late final String root;
  late final List<dynamic> allowedGroupIds;

  ModuleVisibilities.fromJson(Map<String, dynamic> json) {
    root = json['root'];
    allowedGroupIds = json['allowed_group_ids'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['root'] = root;
    data['allowed_group_ids'] = allowedGroupIds;
    return data;
  }

  ModuleVisibilities copyWith({
    root,
    allowedGroupIds,
  }) =>
      ModuleVisibilities(
        root: root ?? this.root,
        allowedGroupIds: allowedGroupIds ?? this.allowedGroupIds,
      );

  @override
  String toString() {
    return 'ModuleVisibilities(root: $root, allowed_group_ids: $allowedGroupIds)';
  }
}

class ModuleVisibility {
  ModuleVisibility({
    required this.root,
    required this.allowedGroupId,
  });
  late final String root;
  late final String allowedGroupId;

  ModuleVisibility.fromJson(Map<String, dynamic> json) {
    root = json['root'];
    allowedGroupId = json['allowed_group_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['root'] = root;
    data['allowed_group_id'] = allowedGroupId;
    return data;
  }

  ModuleVisibility copyWith({
    root,
    allowedGroupId,
  }) =>
      ModuleVisibility(
        root: root ?? this.root,
        allowedGroupId: allowedGroupId ?? this.allowedGroupId,
      );

  @override
  String toString() {
    return 'ModuleVisibility(root: $root, allowed_group_id: $allowedGroupId)';
  }
}
