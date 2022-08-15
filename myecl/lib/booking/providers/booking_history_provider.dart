import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class BookingHistoryProvider extends ListNotifier<Booking> {
  final BookingRepository _repository = BookingRepository();
  BookingHistoryProvider({required String token})
      : super(const AsyncValue.loading()) {
    _repository.setToken(token);
  }

  Future<AsyncValue<List<Booking>>> loadBookings() async {
    return await loadList(_repository.getHistoryBookingList);
  }

  Future<bool> addBooking(Booking booking) async {
    return await add((b) async => b, booking);
  }
}

final bookingHistoryProvider =
    StateNotifierProvider<BookingHistoryProvider, AsyncValue<List<Booking>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  return BookingHistoryProvider(token: token);
});
