import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/event/tools/constants.dart';
import 'package:titan/tools/functions.dart';

final isEventAdminProvider = Provider<bool>((ref) {
  return hasUserPermission(ref, EventPermissionConstants.manageEvents);
});
