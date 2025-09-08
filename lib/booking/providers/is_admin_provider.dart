import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/user/providers/user_provider.dart';

final isAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  return me.groups
      .map((e) => e.id)
      .contains("0a25cb76-4b63-4fd3-b939-da6d9feabf28");
});
