import 'package:flutter/widgets.dart';
import 'package:titan/super_admin/tools/constants.dart';
import 'package:titan/l10n/app_localizations.dart';

String getSchoolNameFromId(String id, String name, BuildContext context) {
  if (id == SchoolIdConstant.noSchool.value) {
    return AppLocalizations.of(context)!.adminNoSchool;
  }
  if (id == SchoolIdConstant.eclSchool.value) {
    return AppLocalizations.of(context)!.adminEclSchool;
  }
  return name;
}
