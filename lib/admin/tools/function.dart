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
