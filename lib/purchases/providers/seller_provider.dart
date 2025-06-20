import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/purchases/class/seller.dart';

class SellerNotifier extends StateNotifier<Seller> {
  SellerNotifier() : super(Seller.empty());

  void setSeller(Seller i) {
    state = i;
  }
}

final sellerProvider = StateNotifierProvider<SellerNotifier, Seller>((ref) {
  SellerNotifier notifier = SellerNotifier();
  return notifier;
});
