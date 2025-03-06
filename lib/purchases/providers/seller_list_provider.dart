import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class SellerListNotifier extends ListNotifierAPI<SellerComplete> {
  final Openapi sellerRepository;
  SellerListNotifier({required this.sellerRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<SellerComplete>>> loadSellers() async {
    return await loadList(sellerRepository.cdrSellersGet);
  }
}

final sellerListProvider =
    StateNotifierProvider<SellerListNotifier, AsyncValue<List<SellerComplete>>>(
        (ref) {
  final sellerRepository = ref.watch(repositoryProvider);
  return SellerListNotifier(sellerRepository: sellerRepository)..loadSellers();
});
