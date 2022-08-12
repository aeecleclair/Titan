import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/tools/exception.dart';

class BookingHistoryProvider extends StateNotifier<AsyncValue<List<Booking>>> {
  final BookingRepository _repository = BookingRepository();
  BookingHistoryProvider({required String token})
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
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        return state;
      }
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
        if (error is AppException && error.type == ErrorType.tokenExpire) {
          throw error;
        } else {
          return false;
        }
      },
      loading: () {
        state = const AsyncValue.error("Cannot add booking while loading");
        return false;
      },
    );
  }
}

final bookingHistoryProvider =
    StateNotifierProvider<BookingHistoryProvider, AsyncValue<List<Booking>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  return BookingHistoryProvider(token: token);
});
