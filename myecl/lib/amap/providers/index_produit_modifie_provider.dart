import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Le provider de l'index du produit modifié
final produitModifProvider = StateNotifierProvider<ProduitModif, int>(
  (ref) {
    return ProduitModif();
  },
);

class ProduitModif extends StateNotifier<int> {
  ProduitModif() : super(-1);

  /// **Permet de changer la valeur**
  ///
  /// Paramètre :
  /// * i (int) le nouvel index du produit à modifier
  void setIndexProduit(int i) {
    state = i;
  }
}
