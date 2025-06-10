import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/purchases/providers/seller_list_provider.dart';
import 'package:titan/user/providers/user_provider.dart';

final isPurchasesAdminProvider = StateProvider<bool>((ref) {
  final user = ref.watch(userProvider);
  final sellers = ref.watch(sellerListProvider);
  if (user.groups
      .map((e) => e.id)
      .contains("c1275229-46b2-4e53-a7c4-305513bb1a2a")) {
    return true;
  }
  return sellers.maybeWhen(
    data: (data) => data.isNotEmpty,
    orElse: () => false,
  );
});
