import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isGreenCodeAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  return me.groups
      .map((e) => e.id)
      .contains("e23d52eb-3fe4-4ce3-91f5-1f645647ef7d");
});
