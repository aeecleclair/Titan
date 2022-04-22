import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/class/res.dart';

class BookingListNotifier extends StateNotifier<List<Booking>> {
  BookingListNotifier([List<Booking>? listBooking]) : super(listBooking ?? []);

  void changeState(Booking res, int newState) {
    List<Booking> r = state.sublist(0);

    for (Booking rs in r) {
      if (res == rs) {
        rs.state = newState;
      }
    }

    state = r;
  }
}

final bookingListProvider =
    StateNotifierProvider<BookingListNotifier, List<Booking>>((ref) {
  return BookingListNotifier([
    Booking(date: "12/04/2020 - 18h30-23h", title: "Réservation 1", state: 0),
    Booking(date: "12/04/2020 - 18h-19h", title: "Réservation 2", state: 0),
    Booking(date: "12/04/2020 - 19h30-21h", title: "Réservation 3", state: 0),
    Booking(date: "12/04/2020 - 18h30-23h", title: "Réservation 4", state: 0),
    Booking(date: "12/04/2020 - 18h-19h", title: "Réservation 5", state: 0),
    Booking(date: "12/04/2020 - 19h30-21h", title: "Réservation 6", state: 0),
    Booking(date: "12/04/2020 - 18h30-23h", title: "Réservation 7", state: 0),
    Booking(date: "12/04/2020 - 18h-19h", title: "Réservation 8", state: 0),
    Booking(date: "12/04/2020 - 19h30-21h", title: "Réservation 9", state: 0),
    Booking(date: "12/04/2020 - 18h30-23h", title: "Réservation 10", state: 0),
  ]);
});
