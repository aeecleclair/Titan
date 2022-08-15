import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_provider.dart';

class BookingListProvider extends ListProvider<Booking> {
  final BookingRepository _repository = BookingRepository();
  BookingListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _repository.setToken(token);
  }

  Future<AsyncValue<List<Booking>>> loadBookings() async {
    return await loadList(_repository.getBookingList);
  }

  Future<bool> addBooking(Booking booking) async {
    return await add(_repository.createBooking, booking);
  }

  Future<bool> updateBooking(Booking booking) async {
    return await update(_repository.updateBooking, (bookings, booking) {
      final bookingsId = bookings.map((e) => e.id).toList();
      final index = bookingsId.indexOf(booking.id);
      bookings[index] = booking;
      return bookings;
    }, booking);
  }

  Future<bool> deleteBooking(Booking booking) async {
    return await delete(_repository.deleteBooking, booking.id, booking);
  }

  Future<bool> toggleConfirmed(String bookingId) async {
    return state.when(
      data: (bookings) async {
        try {
          final booking =
              bookings.firstWhere((element) => element.id == bookingId);
          booking.confirmed = !booking.confirmed;
          await _repository.updateBooking(booking);
          bookings[bookings.indexOf(booking)] = booking;
          state = AsyncValue.data(bookings);
          return true;
        } catch (e) {
          state = AsyncValue.data(bookings);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          return false;
        }
      },
      loading: () {
        state = const AsyncValue.error("Cannot update booking while loading");
        return false;
      },
    );
  }
}

final bookingListProvider =
    StateNotifierProvider<BookingListProvider, AsyncValue<List<Booking>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final provider = BookingListProvider(token: token);
  provider.loadBookings();
  return provider;
});
