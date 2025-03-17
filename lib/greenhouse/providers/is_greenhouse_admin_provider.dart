import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isGreenHouseAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  return me.groups
      .map((e) => e.id)
      .contains("70db65ee-d533-4f6b-9ffa-a4d70a17b7ef");
});
