import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Le provider de l'index de la commande séléctionnée affichée
final indexCmdProvider = StateNotifierProvider<IndexCmd, int>((ref) {
  return IndexCmd();
});

class IndexCmd extends StateNotifier<int> {
  // Par défaut aucune
  IndexCmd() : super(-1);

  /// **Permet de changer la valeur**
  ///
  /// Paramètre :
  /// * i (int) le nouvel index de commande sélectionnée
  void setIndex(int i) {
    state = i;
  }
}
