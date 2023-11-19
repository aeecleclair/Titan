import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserBookingListProvider extends ListNotifier<Booking> {
  final BookingRepository _repository = BookingRepository();
  UserBookingListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _repository.setToken(token);
  }

  Future<AsyncValue<List<Booking>>> loadUserBookings() async {
    return await loadList(() async => _repository.getUserBookingList());
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
}

final userBookingListProvider =
    StateNotifierProvider<UserBookingListProvider, AsyncValue<List<Booking>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final provider = UserBookingListProvider(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadUserBookings();
  });
  return provider;
});
