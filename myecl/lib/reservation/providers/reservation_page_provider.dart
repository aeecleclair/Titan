import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationPage extends StateNotifier<int> {
  // Par défaut, la Reservationpage principale
  ReservationPage() : super(0);

  /// **Permet de changer la valeur et donc la Reservationpage**
  ///
  /// Paramètre :
  /// * i (int) le nouvel index de la Reservationpage
  void setReservationPage(int i) {
    state = i;
  }
}

final reservationPageProvider = StateNotifierProvider<ReservationPage, int>((ref) {
  return ReservationPage();
});
