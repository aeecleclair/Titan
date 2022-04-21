import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Le provider du solde de l'utilisateur de la commande séléctionnée affichée
final soldeProvider = StateNotifierProvider<Solde, double>((ref) {
  return Solde();
});

class Solde extends StateNotifier<double> {
  Solde() : super(105.43);

  /// **Permet de changer la valeur**
  ///
  /// Paramètre :
  /// * i (double) le nouveau solde
  void setsolde(double i) {
    state = i;
  }
}
