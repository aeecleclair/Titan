import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/user/providers/user_provider.dart';

final isSuperAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  return me.isSuperAdmin;
});
