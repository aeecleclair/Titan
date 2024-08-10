import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/class/seller.dart';

class SellerNotifier extends StateNotifier<Seller> {
  SellerNotifier({required String token}) : super(Seller.empty());

  void setSeller(Seller i) {
    state = i;
  }
}

final sellerProvider = StateNotifierProvider<SellerNotifier, Seller>((ref) {
  final token = ref.watch(tokenProvider);
  SellerNotifier notifier = SellerNotifier(token: token);
  return notifier;
});
