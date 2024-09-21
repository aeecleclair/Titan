import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isShotgunAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  for (final group in me.groups) {
    if (group.name == "sg") {
      return true;
    }
  }
  return false;
});
