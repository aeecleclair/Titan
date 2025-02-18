import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isPaymentAdmin = Provider((ref) {
  const paymentAdminGroupId = "5571adfd-47fc-4dde-a44b-6e1289476499";
  final user = ref.watch(userProvider);
  return user.groups.map((e) => e.id).contains(paymentAdminGroupId);
});
