import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:titan/mypayment/providers/my_stores_provider.dart';
import 'package:titan/mypayment/providers/store_sellers_list_provider.dart';
import 'package:titan/user/providers/user_provider.dart';

/// Provider that checks if the current user can manage ticket events
/// (create/edit ticket events) for their stores.
final canManageTicketEventsProvider = Provider<bool>((ref) {
  final myStores = ref.watch(myStoresProvider);
  final currentUser = ref.watch(userProvider);

  return myStores.maybeWhen(
    data: (stores) {
      if (stores.isEmpty) return false;

      for (final store in stores) {
        final sellersAsync = ref.watch(sellerStoreProvider(store.id));
        final hasPermission = sellersAsync.maybeWhen(
          data: (sellers) {
            final meAsSeller = sellers.firstWhereOrNull(
              (seller) => seller.userId == currentUser.id,
            );
            return meAsSeller?.canManageEvents ?? false;
          },
          orElse: () => false,
        );
        if (hasPermission) return true;
      }

      return false;
    },
    orElse: () => false,
  );
});
