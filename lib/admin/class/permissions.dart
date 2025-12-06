class GroupPermission {
  GroupPermission({required this.permissionName, required this.groupId});
  late final String permissionName;
  late final String groupId;
  GroupPermission.fromJson(Map<String, dynamic> json) {
    permissionName = json['permission_name'];
    groupId = json['group_id'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['permission_name'] = permissionName;
    data['group_id'] = groupId;
    return data;
  }

  @override
  String toString() =>
      'GroupPermission(permissionName: $permissionName, groupId: $groupId)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupPermission &&
          permissionName == other.permissionName &&
          groupId == other.groupId;

  @override
  int get hashCode => permissionName.hashCode ^ groupId.hashCode;
}

class AccountTypePermission {
  AccountTypePermission({
    required this.permissionName,
    required this.accountType,
  });

  late final String permissionName;
  late final String accountType;

  AccountTypePermission.fromJson(Map<String, dynamic> json) {
    permissionName = json['permission_name'];
    accountType = json['account_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['permission_name'] = permissionName;
    data['account_type'] = accountType;
    return data;
  }

  @override
  String toString() =>
      'AccountTypePermission(permissionName: $permissionName, accountType: $accountType)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountTypePermission &&
          permissionName == other.permissionName &&
          accountType == other.accountType;

  @override
  int get hashCode => permissionName.hashCode ^ accountType.hashCode;
}

class Permission {
  Permission({
    required this.permissionName,
    required this.authorizedAccountTypes,
    required this.authorizedGroups,
  });

  late final String permissionName;
  late final List<String> authorizedAccountTypes;
  late final List<String> authorizedGroups;

  @override
  String toString() =>
      'Permission(permissionName: $permissionName, authorizedAccountTypes: $authorizedAccountTypes, authorizedGroups: $authorizedGroups)';
}

class AllPermissions {
  AllPermissions({
    required this.groupPermissions,
    required this.accountTypePermissions,
  });

  late final List<GroupPermission> groupPermissions;
  late final List<AccountTypePermission> accountTypePermissions;

  AllPermissions.fromJson(Map<String, dynamic> json) {
    groupPermissions = List.from(
      json['group_permissions'],
    ).map((e) => GroupPermission.fromJson(e)).toList();
    accountTypePermissions = List.from(
      json['account_type_permissions'],
    ).map((e) => AccountTypePermission.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['group_permissions'] = groupPermissions
        .map((e) => e.toJson())
        .toList();
    data['account_type_permissions'] = accountTypePermissions
        .map((e) => e.toJson())
        .toList();
    return data;
  }

  AllPermissions copyWith({
    List<GroupPermission>? groupPermissions,
    List<AccountTypePermission>? accountTypePermissions,
  }) => AllPermissions(
    groupPermissions: groupPermissions ?? this.groupPermissions,
    accountTypePermissions:
        accountTypePermissions ?? this.accountTypePermissions,
  );

  AllPermissions.empty() {
    groupPermissions = [];
    accountTypePermissions = [];
  }

  @override
  String toString() {
    return 'GroupPermissions(groupPermissions: $groupPermissions, accountTypePermissions: $accountTypePermissions)';
  }
}
