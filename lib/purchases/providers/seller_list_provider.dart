import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class SellerListNotifier extends ListNotifierAPI<SellerComplete> {
  Openapi get sellerRepository => ref.watch(repositoryProvider);
  AsyncValue<List<SellerComplete>> sellerList = const AsyncValue.loading();

  @override
  AsyncValue<List<SellerComplete>> build() {
    loadSellers();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<SellerComplete>>> loadSellers() async {
    return await loadList(sellerRepository.cdrSellersGet);
  }
}

final sellerListProvider =
    NotifierProvider<SellerListNotifier, AsyncValue<List<SellerComplete>>>(
      SellerListNotifier.new,
    );
