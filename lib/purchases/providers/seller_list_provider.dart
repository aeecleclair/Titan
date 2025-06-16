import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/class/seller.dart';
import 'package:myecl/purchases/repositories/user_information_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class SellerListNotifier extends ListNotifier<Seller> {
  final UserInformationRepository sellerRepository;
  AsyncValue<List<Seller>> sellerList = const AsyncValue.loading();
  SellerListNotifier(this.sellerRepository) : super(const AsyncValue.loading());

  Future<AsyncValue<List<Seller>>> loadSellers() async {
    return await loadList(sellerRepository.getSellerList);
  }
}

final sellerListProvider =
    StateNotifierProvider<SellerListNotifier, AsyncValue<List<Seller>>>((ref) {
      final userInformationRepository = ref.watch(
        userInformationRepositoryProvider,
      );
      SellerListNotifier notifier = SellerListNotifier(
        userInformationRepository,
      );
      notifier.loadSellers();
      return notifier;
    });
