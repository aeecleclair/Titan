import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/purchases/repositories/user_information_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class ProductIdNotifier extends SingleNotifier<String> {
  final UserInformationRepository productIdRepository =
      UserInformationRepository();
  ProductIdNotifier({required String token})
    : super(const AsyncValue.loading()) {
    productIdRepository.setToken(token);
  }

  void setProductId(String i) {
    state = AsyncValue.data(i);
  }
}

final productIdProvider =
    StateNotifierProvider<ProductIdNotifier, AsyncValue<String>>((ref) {
      final token = ref.watch(tokenProvider);
      ProductIdNotifier notifier = ProductIdNotifier(token: token);
      return notifier;
    });
