import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/user/providers/user_provider.dart';

final isEventAdminProvider = StateProvider<bool>((ref) {
  final me = ref.watch(userProvider);
  return me.groups
      .map((e) => e.id)
      .contains("b0357687-2211-410a-9e2a-144519eeaafa"); // admin_calendar
});
