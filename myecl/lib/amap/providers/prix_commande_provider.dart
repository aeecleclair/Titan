import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Le provider du prix de l'utilisateur de la commande séléctionnée
final prixProvider = StateNotifierProvider<Prix, double>((ref) {
  return Prix();
});

class Prix extends StateNotifier<double> {
  // Par défaut, 0
  Prix() : super(0.0);

  /// **Permet de changer la valeur**
  ///
  /// Paramètre :
  /// * i (double) le nouveau prix de la commande sélectionnée
  void setPrix(double i) {
    state = i;
  }
}
