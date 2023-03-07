import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TombolaPage {
  main,
  tombola,
  create,
  addEdit,
  admin,
}

final tombolaPageProvider =
    StateNotifierProvider<TombolaPageNotifier, TombolaPage>((ref) {
  return TombolaPageNotifier();
});

class TombolaPageNotifier extends StateNotifier<TombolaPage> {
  TombolaPageNotifier() : super(TombolaPage.main);

  void setTombolaPage(TombolaPage i) {
    state = i;
  }
}
