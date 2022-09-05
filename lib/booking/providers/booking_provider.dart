import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';

class BookingNotifier extends StateNotifier<Booking> {
  BookingNotifier() : super(Booking.empty());

  void setBooking(Booking booking) {
    state = booking;
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, Booking>((ref) {
  return BookingNotifier();
});
