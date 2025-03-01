import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class SellerListNotifier extends ListNotifier2<SellerComplete> {
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
  SellerListNotifier notifier =
      SellerListNotifier(sellerRepository: sellerRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadSellers();
  });
  return notifier;
});
