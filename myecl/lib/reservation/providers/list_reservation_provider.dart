import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/reservation/class/res.dart';

class ReservationListNotifier extends StateNotifier<List<Reservation>> {
  ReservationListNotifier([List<Reservation>? listReservation])
      : super(listReservation ?? []);

  void changeState(Reservation res, int newState) {
    List<Reservation> r = state.sublist(0);

    for (Reservation rs in r) {
      if (res == rs) {
        rs.state = newState;
      }
    }

    state = r;
  }
}

final listReservationProvider =
    StateNotifierProvider<ReservationListNotifier, List<Reservation>>((ref) {
  return ReservationListNotifier([
    Reservation(
        date: "12/04/2020 - 18h30-23h", title: "Réservation 1", state: 0),
    Reservation(date: "12/04/2020 - 18h-19h", title: "Réservation 2", state: 0),
    Reservation(
        date: "12/04/2020 - 19h30-21h", title: "Réservation 3", state: 0),
    Reservation(
        date: "12/04/2020 - 18h30-23h", title: "Réservation 4", state: 0),
    Reservation(date: "12/04/2020 - 18h-19h", title: "Réservation 5", state: 0),
    Reservation(
        date: "12/04/2020 - 19h30-21h", title: "Réservation 6", state: 0),
    Reservation(
        date: "12/04/2020 - 18h30-23h", title: "Réservation 7", state: 0),
    Reservation(date: "12/04/2020 - 18h-19h", title: "Réservation 8", state: 0),
    Reservation(
        date: "12/04/2020 - 19h30-21h", title: "Réservation 9", state: 0),
    Reservation(
        date: "12/04/2020 - 18h30-23h", title: "Réservation 10", state: 0),
  ]);
});
