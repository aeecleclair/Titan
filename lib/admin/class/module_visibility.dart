class ModuleVisibility {
  ModuleVisibility({
    required this.root,
    required this.allowedGroupIds,
    this.isExpanded = false,
  });
  late final String root;
  late final List<String> allowedGroupIds;
  late bool isExpanded = false;

  ModuleVisibility.fromJson(Map<String, dynamic> json) {
    root = json['root'];
    allowedGroupIds = List<String>.from(json['allowed_group_ids']);
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
    bool? isExpanded,
  }) =>
      ModuleVisibility(
        root: root ?? this.root,
        allowedGroupIds: allowedGroupIds ?? this.allowedGroupIds,
        isExpanded: isExpanded ?? this.isExpanded,
      );

  ModuleVisibility.empty() {
    root = '';
    allowedGroupIds = [];
    isExpanded = false;
  }

  @override
  String toString() {
    return 'ModuleVisibility(root: $root, allowedGroupIds: $allowedGroupIds, isExpanded: $isExpanded)';
  }
}
