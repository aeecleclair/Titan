import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isMemeAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  for (final group in me.groups) {
    if (group.name == "Meme") {
      return true;
    }
  }
  return false;
});
