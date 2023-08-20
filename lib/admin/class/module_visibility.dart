class ModuleVisibilities {
  ModuleVisibilities({
    required this.root,
    required this.allowedGroupIds,
  });
  late final String root;
  late final List<String> allowedGroupIds;

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