import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Le provider de la catégorie sélectionnée
final cateSelectionneeProvider =
    StateNotifierProvider.family<CateSelectionnee, String, String>(
  (ref, txt) {
    return CateSelectionnee(txt);
  },
);

class CateSelectionnee extends StateNotifier<String> {
  String txt;
  CateSelectionnee(this.txt) : super(txt);

  /// **Permet de changer la valeur**
  ///
  /// Paramètre :
  /// * i (int) le nouvel index du produit à modifier
  void setText(String txt) {
    state = txt;
  }
}
