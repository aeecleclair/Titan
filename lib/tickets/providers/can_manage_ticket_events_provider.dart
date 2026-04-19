import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/mypayment/class/seller.dart';
import 'package:titan/mypayment/providers/my_stores_provider.dart';
import 'package:titan/mypayment/providers/store_sellers_list_provider.dart';
import 'package:titan/user/providers/user_provider.dart';

/// Provider that checks if the current user can manage ticket events
/// (create/edit ticket events) for their stores.
/// Returns true if:
/// - The user is a structure admin of at least one store, OR
/// - The user is a seller with canManageEvent=true in at least one store
final canManageTicketEventsProvider = Provider<bool>((ref) {
  final myStores = ref.watch(myStoresProvider);
  final currentUser = ref.watch(userProvider);

  return myStores.maybeWhen(
    data: (stores) {
      if (stores.isEmpty) return false;

      // Check if user is a structure admin of any store
      for (final store in stores) {
        if (store.structure.managerUser.id == currentUser.id) {
          return true;
        }
      }

      // Check if user is a seller with canManageEvent in any store
      for (final store in stores) {
        final sellersAsync = ref.watch(sellerStoreProvider(store.id));
        final hasPermission = sellersAsync.maybeWhen(
          data: (sellers) {
            // Find the current user in the sellers list
            final meAsSeller = sellers.firstWhere(
              (seller) => seller.userId == currentUser.id,
              orElse: () => Seller.empty(),
            );
            return meAsSeller.canManageEvent;
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
