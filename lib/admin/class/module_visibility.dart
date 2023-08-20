class ModuleVisibility {
  ModuleVisibility({
    required this.root,
    required this.allowedGroupIds,
    this.isExpanded = false,
  });
  late final String root;
  late final List<dynamic> allowedGroupIds;
  late bool isExpanded;

  ModuleVisibility.fromJson(Map<String, dynamic> json) {
    root = json['root'];
    allowedGroupIds = json['allowed_group_ids'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['root'] = root;
    data['allowed_group_ids'] = allowedGroupIds;
    return data;
  }

  ModuleVisibility copyWith({
    root,
    allowedGroupIds,
  }) =>
      ModuleVisibility(
        root: root ?? this.root,
        allowedGroupIds: allowedGroupIds ?? this.allowedGroupIds,
      );

  @override
  String toString() {
    return 'ModuleVisibility(root: $root, allowed_group_ids: $allowedGroupIds)';
  }
}
