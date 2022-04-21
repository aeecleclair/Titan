import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReservationPage extends StateNotifier<int> {
  ReservationPage() : super(0);

  void setReservationPage(int i) {
    state = i;
  }
}

final reservationPageProvider =
    StateNotifierProvider<ReservationPage, int>((ref) {
  return ReservationPage();
});
