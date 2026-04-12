import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/ph/tools/constants.dart';
import 'package:titan/tools/functions.dart';

final isPhAdminProvider = StateProvider<bool>((ref) {
  return hasUserPermission(ref, PhPermissionConstants.managePh);
});
