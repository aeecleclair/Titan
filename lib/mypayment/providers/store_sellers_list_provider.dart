import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class StoreSellerListNotifier extends ListNotifierAPI<Seller> {
  Openapi get sellerStoreRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Seller>> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Seller>>> getStoreSellerList(String storeId) async {
    return await loadList(
      () => sellerStoreRepository.mypaymentStoresStoreIdSellersGet(
        storeId: storeId,
      ),
    );
  }

  Future<bool> createStoreSeller(Seller seller) async {
    return await add(
      () => sellerStoreRepository.mypaymentStoresStoreIdSellersPost(
        storeId: seller.storeId,
        body: SellerCreation(
          userId: seller.userId,
          canBank: seller.canBank,
          canSeeHistory: seller.canSeeHistory,
          canCancel: seller.canCancel,
          canManageSellers: seller.canManageSellers,
        ),
      ),
      seller,
    );
  }

  Future<bool> deleteStoreSeller(Seller seller) async {
    return await delete(
      () =>
          sellerStoreRepository.mypaymentStoresStoreIdSellersSellerUserIdDelete(
            storeId: seller.storeId,
            sellerUserId: seller.userId,
          ),
      (seller) => seller.userId,
      seller.storeId,
    );
  }

  Future<bool> updateStoreSeller(Seller seller) async {
    return await update(
      () =>
          sellerStoreRepository.mypaymentStoresStoreIdSellersSellerUserIdPatch(
            storeId: seller.storeId,
            sellerUserId: seller.userId,
            body: SellerUpdate(
              canBank: seller.canBank,
              canSeeHistory: seller.canSeeHistory,
              canCancel: seller.canCancel,
              canManageSellers: seller.canManageSellers,
            ),
          ),
      (seller) => seller.userId,
      seller,
    );
  }
}

final sellerStoreProvider =
    NotifierProvider.family<
      StoreSellerListNotifier,
      AsyncValue<List<Seller>>,
      String
    >((storeId) => StoreSellerListNotifier());
