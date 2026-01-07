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

class CorePermission {
  CorePermission({
    required this.permissionName,
    required this.authorizedAccountTypes,
    required this.authorizedGroupIds,
  });

  late final String permissionName;
  late final List<String> authorizedAccountTypes;
  late final List<String> authorizedGroupIds;

  CorePermission.fromJson(Map<String, dynamic> json) {
    permissionName = json['permission_name'];
    authorizedAccountTypes = List<String>.from(json['account_types']);
    authorizedGroupIds = List<String>.from(json['groups']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['permission_name'] = permissionName;
    data['account_types'] = authorizedAccountTypes;
    data['groups'] = authorizedGroupIds;
    return data;
  }

  CorePermission copyWith({
    String? permissionName,
    List<String>? authorizedAccountTypes,
    List<String>? authorizedGroupIds,
  }) {
    return CorePermission(
      permissionName: permissionName ?? this.permissionName,
      authorizedAccountTypes:
          authorizedAccountTypes ?? this.authorizedAccountTypes,
      authorizedGroupIds: authorizedGroupIds ?? this.authorizedGroupIds,
    );
  }

  CorePermission.empty() {
    permissionName = '';
    authorizedAccountTypes = [];
    authorizedGroupIds = [];
  }

  @override
  String toString() =>
      'CorePermission(permissionName: $permissionName, authorizedAccountTypes: $authorizedAccountTypes, authorizedGroupIds: $authorizedGroupIds)';
}
