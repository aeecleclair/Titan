import 'package:titan/admin/class/account_type.dart';

class ModuleVisibility {
  ModuleVisibility({
    required this.root,
    required this.allowedGroupIds,
    required this.allowedAccountTypes,
  });
  late final String root;
  late final List<String> allowedGroupIds;
  late final List<AccountType> allowedAccountTypes;

  ModuleVisibility.fromJson(Map<String, dynamic> json) {
    root = json['root'];
    allowedGroupIds = List<String>.from(json['allowed_group_ids']);
    allowedAccountTypes = List.from(
      json['allowed_account_types'],
    ).map((x) => AccountType(type: x)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['root'] = root;
    data['allowed_group_ids'] = allowedGroupIds;
    data['allowed_account_types'] = allowedAccountTypes;
    return data;
  }

  ModuleVisibility copyWith({
    String? root,
    List<String>? allowedGroupIds,
    List<AccountType>? allowedAccountTypes,
  }) => ModuleVisibility(
    root: root ?? this.root,
    allowedGroupIds: allowedGroupIds ?? this.allowedGroupIds,
    allowedAccountTypes: allowedAccountTypes ?? this.allowedAccountTypes,
  );

  ModuleVisibility.empty() {
    root = '';
    allowedGroupIds = [];
    allowedAccountTypes = [];
  }

  @override
  String toString() {
    return 'ModuleVisibility(root: $root, allowedGroupIds: $allowedGroupIds, allowedAccounTypes: $allowedAccountTypes)';
  }
}
