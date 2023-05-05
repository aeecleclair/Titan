import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PaiementPage { main, scan, pay }

class PaiementPageProvider extends StateNotifier<PaiementPage> {
  PaiementPageProvider() : super(PaiementPage.main);

  void setPaiementPage(PaiementPage i) {
    state = i;
  }
}

final paiementPageProvider =
    StateNotifierProvider<PaiementPageProvider, PaiementPage>((ref) {
  return PaiementPageProvider();
});
