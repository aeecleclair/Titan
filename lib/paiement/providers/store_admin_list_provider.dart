import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/seller.dart';
import 'package:myecl/paiement/repositories/seller_admin_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class StoreAdminListNotifier extends ListNotifier<Seller> {
  final SellerAdminsRepository storeAdminsRepository;
  StoreAdminListNotifier({required this.storeAdminsRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Seller>>> getStoreAdminList(String storeId) async {
    return await loadList(() => storeAdminsRepository.getStoreAdmins(storeId));
  }

  Future<bool> createStoreAdmin(Seller seller) async {
    return await add(
      (seller) => storeAdminsRepository.createSellerAdmin(
        seller.storeId,
        seller.userId,
      ),
      seller,
    );
  }

  Future<bool> deleteStoreAdmin(Seller seller) async {
    return await delete(
      (_) => storeAdminsRepository.deleteStoreAdmin(
        seller.storeId,
        seller.userId,
      ),
      (sellers, seller) =>
          sellers.where((s) => s.userId != seller.userId).toList(),
      seller.userId,
      seller,
    );
  }
}

final storeAdminListProvider =
    StateNotifierProvider<StoreAdminListNotifier, AsyncValue<List<Seller>>>(
        (ref) {
  final storeAdminListRepository = ref.watch(sellerAdminsRepositoryProvider);
  return StoreAdminListNotifier(
    storeAdminsRepository: storeAdminListRepository,
  );
});
