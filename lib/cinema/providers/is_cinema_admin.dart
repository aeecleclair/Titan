import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/cinema/tools/constants.dart';
import 'package:titan/tools/functions.dart';

final isCinemaAdminProvider = Provider<bool>((ref) {
  return hasUserPermission(ref, CinemaPermissionConstants.manageSessions);
});
