import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/repositories/user_information_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class ProductIdNotifier extends SingleNotifier<String> {
  final UserInformationRepository productIdRepository;
  ProductIdNotifier(this.productIdRepository)
    : super(const AsyncValue.loading());

  void setProductId(String i) {
    state = AsyncValue.data(i);
  }
}

final productIdProvider =
    StateNotifierProvider<ProductIdNotifier, AsyncValue<String>>((ref) {
      final productIdRepository = ref.watch(userInformationRepositoryProvider);
      ProductIdNotifier notifier = ProductIdNotifier(productIdRepository);
      return notifier;
    });
