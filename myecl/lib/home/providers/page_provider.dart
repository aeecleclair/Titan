import 'package:flutter_riverpod/flutter_riverpod.dart';

class Page extends StateNotifier<int> {
  // Par défaut, la page principale
  Page() : super(0);

  /// **Permet de changer la valeur et donc la page**
  ///
  /// Paramètre :
  /// * i (int) le nouvel index de la page
  void setPage(int i) {
    state = i;
  }
}

final pageProvider = StateNotifierProvider<Page, int>((ref) {
  return Page();
});
