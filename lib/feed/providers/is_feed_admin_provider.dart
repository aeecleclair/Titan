import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/user/providers/user_provider.dart';

final isFeedAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  for (final group in me.groups) {
    if (group.name == "feed_admin") {
      return true;
    }
  }
  return false;
});
