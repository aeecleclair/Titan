import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/providers/my_stores_provider.dart';
import 'package:myecl/user/providers/user_provider.dart';

final isPaymentAdminProvider = StateProvider((ref) {
  final user = ref.watch(userProvider);
  final myStores = ref.watch(myStoresProvider);
  return myStores.when(
    data: (stores) => (stores
        .map((store) => store.structure.managerUserId)
        .contains(user.id)),
    loading: () => false,
    error: (error, stack) => false,
  );
});
