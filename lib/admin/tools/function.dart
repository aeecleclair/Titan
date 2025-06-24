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
