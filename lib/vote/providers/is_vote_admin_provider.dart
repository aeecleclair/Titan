import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/user/providers/user_provider.dart';

final isVoteAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  return me.groups
      .map((e) => e.id)
      .contains("6c6d7e88-fdb8-4e42-b2b5-3d3cfd12e7d6");
});
