import 'package:titan/admin/tools/constants.dart';

String getSchoolNameFromId(String id, String name) {
  if (id == SchoolIdConstant.noSchool.value) {
    return AdminTextConstants.noSchool;
  }
  if (id == SchoolIdConstant.eclSchool.value) {
    return AdminTextConstants.eclSchool;
  }
  return name;
}

String capitalizePermissionName(String permissionName) {
  return permissionName
      .split('_')
      .map(
        (word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : word,
      )
      .join(' ');
}

Map<String, List<String>> groupPermissionsNamesByModule(
  List<String> permissionNames,
) {
  final Map<String, List<String>> modulesPermissions = {};

  for (var permissionName in permissionNames) {
    final moduleName = permissionName.split('.').first;
    if (!modulesPermissions.containsKey(moduleName)) {
      modulesPermissions[moduleName] = [permissionName.split('.')[1]];
    } else {
      modulesPermissions[moduleName]!.add(permissionName.split('.')[1]);
    }
  }
  return modulesPermissions;
}
