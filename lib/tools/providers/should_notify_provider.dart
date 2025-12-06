import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/account_type.dart';
import 'package:titan/user/providers/user_provider.dart';

AccountType external = AccountType(type: 'external');
AccountType otherSchoolStudent = AccountType(type: 'other_school_student');

final shouldNotifyProvider = Provider((ref) {
  final asyncUser = ref.watch(asyncUserProvider);
  return asyncUser.maybeWhen(
    data: (user) =>
        user.accountType == external || user.accountType == otherSchoolStudent,
    orElse: () => false,
  );
});
