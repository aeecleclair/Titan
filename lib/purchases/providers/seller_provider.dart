import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class SellerNotifier extends StateNotifier<SellerComplete> {
  SellerNotifier() : super(EmptyModels.empty<SellerComplete>());

  void setSeller(SellerComplete i) {
    state = i;
  }
}

final sellerProvider =
    StateNotifierProvider<SellerNotifier, SellerComplete>((ref) {
  SellerNotifier notifier = SellerNotifier();
  return notifier;
});
