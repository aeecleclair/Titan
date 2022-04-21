import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Le provider de l'index de la IsAdmin affichée
final isAdminProvider = StateNotifierProvider<IsAdmin, bool>((ref) {
  return IsAdmin();
});

class IsAdmin extends StateNotifier<bool> {
  // Par défaut, la IsAdmin principale
  IsAdmin() : super(true);

  /// **Permet de changer la valeur et donc la IsAdmin**
  ///
  /// Paramètre :
  /// * i (int) le nouvel index de la IsAdmin
  void setIsAdmin(bool i) {
    state = i;
  }
}
