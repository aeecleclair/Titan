class ModuleVisibility {
  ModuleVisibility({
    required this.root,
    required this.allowedGroupIds,
  });
  late final String root;
  late final List<String> allowedGroupIds;

  ModuleVisibility.fromJson(Map<String, dynamic> json) {
    root = json['root'] as String;
    allowedGroupIds = json['allowed_group_ids'] as List<String>;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['root'] = root;
    data['allowed_group_ids'] = allowedGroupIds;
    return data;
  }

  ModuleVisibility copyWith({
    String? root,
    List<String>? allowedGroupIds,
  }) =>
      ModuleVisibility(
        root: root ?? this.root,
        allowedGroupIds: allowedGroupIds ?? this.allowedGroupIds,
      );

  ModuleVisibility.empty() {
    root = '';
    allowedGroupIds = [];
  }

  @override
  String toString() {
    return 'ModuleVisibility(root: $root, allowedGroupIds: $allowedGroupIds)';
  }
}
