import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isEventAdmin = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  return me.groups.map((e) => e.name).contains("BDE");
});
