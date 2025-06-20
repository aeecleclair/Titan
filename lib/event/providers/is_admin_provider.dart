import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isEventAdminProvider = StateProvider<bool>((ref) {
  final groups = ref.watch(userProvider.select((value) => value.groups));
  return groups
      .map((e) => e.id)
      .contains("53a669d6-84b1-4352-8d7c-421c1fbd9c6a");
});
