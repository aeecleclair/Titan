import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/tools/functions.dart';

final isAmapAdminProvider = Provider<bool>((ref) {
  return hasUserPermission(ref, AMAPPermissionConstants.manageAMAP);
});
