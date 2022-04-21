import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Le provider de l'index de la AmapPage affichée
final amapPageProvider = StateNotifierProvider<AmapPage, int>((ref) {
  return AmapPage();
});

class AmapPage extends StateNotifier<int> {
  // Par défaut, la AmapPage principale
  AmapPage() : super(0);

  /// **Permet de changer la valeur et donc la AmapPage**
  ///
  /// Paramètre :
  /// * i (int) le nouvel index de la AmapPage
  void setAmapPage(int i) {
    state = i;
  }
}
