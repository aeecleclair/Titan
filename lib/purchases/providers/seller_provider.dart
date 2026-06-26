import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class SellerNotifier extends Notifier<SellerComplete> {
  @override
  SellerComplete build() {
    return SellerComplete.empty();
  }

  void setSeller(SellerComplete i) {
    state = i;
  }
}

final sellerProvider = NotifierProvider<SellerNotifier, SellerComplete>(
  SellerNotifier.new,
);
