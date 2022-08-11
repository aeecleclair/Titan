import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/tools/exception.dart';

class BookingListProvider extends StateNotifier<AsyncValue<List<Booking>>> {
  final BookingRepository _repository = BookingRepository();
  BookingListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _repository.setToken(token);
  }

  Future<AsyncValue<List<Booking>>> loadBookings() async {
    try {
      final bookings = await _repository.getBookingList();
      state = AsyncValue.data(bookings);
      return state;
    } catch (e) {
      state = AsyncValue.error(e);
      rethrow;
    }
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
        throw error as AppException;
      },
      loading: () {
        state = const AsyncValue.error("Cannot add booking while loading");
        return false;
      },
    );
  }

  Future<bool> updateBooking(Booking booking) async {
    return state.when(
      data: (bookings) async {
        try {
          await _repository.updateBooking(booking);
          var index =
              bookings.indexWhere((element) => element.id == booking.id);
          bookings[index] = booking;
          state = AsyncValue.data(bookings);
          return true;
        } catch (e) {
          state = AsyncValue.data(bookings);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        throw error as AppException;
      },
      loading: () {
        state = const AsyncValue.error("Cannot update booking while loading");
        return false;
      },
    );
  }

  Future<bool> deleteBooking(Booking booking) async {
    return state.when(
      data: (bookings) async {
        try {
          await _repository.deleteBooking(booking);
          bookings.removeWhere((element) => element.id == booking.id);
          state = AsyncValue.data(bookings);
          return true;
        } catch (e) {
          state = AsyncValue.data(bookings);
          return false;
        }
      },
      error: (error, s) {
        state = AsyncValue.error(error);
        throw error as AppException;
      },
      loading: () {
        state = const AsyncValue.error("Cannot delete booking while loading");
        return false;
      },
    );
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
        throw error as AppException;
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
