import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/user/providers/user_provider.dart';

final shouldNotifyProvider = Provider((ref) {
  final asyncUser = ref.watch(asyncUserProvider);
  return asyncUser.maybeWhen(
    data: (user) => !isStudent(user.email) && isNotStaff(user.email),
    orElse: () => false,
  );
});
