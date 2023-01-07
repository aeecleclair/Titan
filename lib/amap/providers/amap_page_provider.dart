import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AmapPage {
  main,
  pres,
  addProducts,
  admin,
  addEditProduct,
  addEditDelivery,
  detailPage
}

final amapPageProvider =
    StateNotifierProvider<AmapPageNotifier, AmapPage>((ref) {
  return AmapPageNotifier();
});

class AmapPageNotifier extends StateNotifier<AmapPage> {
  AmapPageNotifier() : super(AmapPage.main);

  void setAmapPage(AmapPage i) {
    state = i;
  }
}
