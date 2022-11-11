import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isVoteAdmin = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  return me.groups.map((e) => e.name).contains("admin");
});
