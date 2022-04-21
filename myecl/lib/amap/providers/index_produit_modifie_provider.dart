import 'package:flutter_riverpod/flutter_riverpod.dart';

final produitModifProvider = StateNotifierProvider<ProduitModif, int>(
  (ref) {
    return ProduitModif();
  },
);

class ProduitModif extends StateNotifier<int> {
  ProduitModif() : super(-1);

  void setIndexProduit(int i) {
    state = i;
  }
}
