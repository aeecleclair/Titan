import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/seed-library/tools/constants.dart';
import 'package:titan/tools/functions.dart';

final isSeedLibraryAdminProvider = StateProvider<bool>((ref) {
  return hasUserPermission(
    ref,
    SeedLibraryPermissionConstants.manageSeedLibrary,
  );
});
