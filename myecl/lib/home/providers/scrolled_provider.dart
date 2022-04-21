import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Le provider de l'index de la HasScrolled affichée
final hasScrolledProvider = StateNotifierProvider<HasScrolled, bool>((ref) {
  return HasScrolled();
});

class HasScrolled extends StateNotifier<bool> {
  // Par défaut, la HasScrolled principale
  HasScrolled() : super(false);

  /// **Permet de changer la valeur et donc la HasScrolled**
  ///
  /// Paramètre :
  /// * i (int) le nouvel index de la HasScrolled
  void setHasScrolled(bool i) {
    state = i;
  }
}
