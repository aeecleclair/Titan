import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';

/// Le provider de la catégorie sélectionnée
final nouvelleCategorieProvider =
    StateNotifierProvider<NouvelleCategorie, TextEditingController>(
  (ref) {
    return NouvelleCategorie();
  },
);

class NouvelleCategorie extends StateNotifier<TextEditingController> {
  NouvelleCategorie() : super(TextEditingController());

  /// **Permet de changer la valeur**
  ///
  /// Paramètre :
  /// * i (int) le nouvel index du produit à modifier
  void setText(String txt) {
    state.text = txt;
  }
}
