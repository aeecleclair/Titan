import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/purchases/class/seller.dart';
import 'package:titan/purchases/repositories/user_information_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class SellerListNotifier extends ListNotifier<Seller> {
  final UserInformationRepository sellerRepository =
      UserInformationRepository();
  AsyncValue<List<Seller>> sellerList = const AsyncValue.loading();
  SellerListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    sellerRepository.setToken(token);
  }

  Future<AsyncValue<List<Seller>>> loadSellers() async {
    return await loadList(sellerRepository.getSellerList);
  }
}

final sellerListProvider =
    StateNotifierProvider<SellerListNotifier, AsyncValue<List<Seller>>>((ref) {
      final token = ref.watch(tokenProvider);
      SellerListNotifier notifier = SellerListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadSellers();
      });
      return notifier;
    });
