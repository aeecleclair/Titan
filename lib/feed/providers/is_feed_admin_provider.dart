import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/user/providers/user_provider.dart';

final isFeedAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  return me.groups
      .map((e) => e.id)
      .contains("59e3c4c2-e60f-44b6-b0d2-fa1b248423bb"); // admin_feed
});
