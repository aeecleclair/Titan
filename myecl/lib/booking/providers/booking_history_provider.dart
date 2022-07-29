import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/class/res.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';

class BookingHistoryProvider extends StateNotifier<AsyncValue<List<Booking>>> {
  final BookingRepository _repository = BookingRepository();
  BookingHistoryProvider() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Booking>>> loadBookings() async {
    try {
      final bookings = await _repository.getBookingList();
      state = AsyncValue.data(bookings);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<bool> addBooking(Booking booking) async {
    return state.when(
      data: (bookings) async {
        try {
          await _repository.createBooking(booking);
          bookings.add(booking);
          state = AsyncValue.data(bookings);
          return true;
        } catch (e) {
          state = AsyncValue.data(bookings);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        return false;
      },
      loading: () {
        state = const AsyncValue.error("Cannot add booking while loading");
        return false;
      },
    );
  }
}

final bookingHistoryProvider =
    StateNotifierProvider<BookingHistoryProvider, AsyncValue<List<Booking>>>((ref) {
  return BookingHistoryProvider();
});