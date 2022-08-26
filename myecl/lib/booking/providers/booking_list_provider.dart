import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/booking/repositories/user_booking_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class BookingListProvider extends ListNotifier<Booking> {
  final BookingRepository _repository = BookingRepository();
  final UserBookingRepository _userRepository = UserBookingRepository();
  BookingListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _repository.setToken(token);
    _userRepository.setToken(token);
  }

  Future<AsyncValue<List<Booking>>> loadBookings(String userId) async {
    return await loadList(() async => _userRepository.getBookingList(userId));
  }

  Future<bool> addBooking(Booking booking) async {
    return await add(_repository.createBooking, booking);
  }

  Future<bool> updateBooking(Booking booking) async {
    return await update(
        _repository.updateBooking,
        (bookings, booking) => bookings
          ..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
        booking);
  }

  Future<bool> deleteBooking(Booking booking) async {
    return await delete(
        _repository.deleteBooking,
        (bookings, booking) => bookings..removeWhere((i) => i.id == booking.id),
        booking.id,
        booking);
  }

  Future<bool> toggleConfirmed(Booking booking, bool value) async {
    return await update(
        (booking) => _repository.confirmBooking(booking, value),
        (bookings, booking) => bookings
          ..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
        booking.copyWith(decision: value ? Decision.approved : Decision.declined));
  }
}

final bookingListProvider =
    StateNotifierProvider<BookingListProvider, AsyncValue<List<Booking>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final userId = ref.watch(idProvider);
  final provider = BookingListProvider(token: token);
  provider.loadBookings(userId);
  return provider;
});
