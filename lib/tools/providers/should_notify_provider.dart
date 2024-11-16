import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/providers/user_provider.dart';

final shouldNotifyProvider = Provider((ref) {
  final asyncUser = ref.watch(asyncUserProvider);
  return asyncUser.maybeWhen(
    data: (user) => !isStudent(user.email) && isNotStaff(user.email),
    orElse: () => false,
  );
});
