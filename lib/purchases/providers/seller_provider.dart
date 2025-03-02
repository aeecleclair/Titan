import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class SellerNotifier extends StateNotifier<SellerComplete> {
  SellerNotifier() : super(SellerComplete.fromJson({}));

  void setSeller(SellerComplete i) {
    state = i;
  }
}

final sellerProvider =
    StateNotifierProvider<SellerNotifier, SellerComplete>((ref) {
  SellerNotifier notifier = SellerNotifier();
  return notifier;
});
