import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isCMMAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  for (final group in me.groups) {
    if (group.name == "CMM") {
      return true;
    }
  }
  return false;
});
