import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ManagerBookingListProvider extends ListNotifier<Booking> {
  final BookingRepository _repository = BookingRepository();
  ManagerBookingListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _repository.setToken(token);
  }

  Future<AsyncValue<List<Booking>>> loadUserManageBookings() async {
    return await loadList(_repository.getUserManageBookingList);
  }

  Future<bool> updateBooking(Booking booking) async {
    return await update(
        _repository.updateBooking,
        (bookings, booking) => bookings
          ..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
        booking);
  }

  Future<bool> toggleConfirmed(Booking booking, Decision decision) async {
    return await update(
        (booking) => _repository.confirmBooking(booking, decision),
        (bookings, booking) => bookings
          ..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
        booking.copyWith(decision: decision));
  }
}

final managerBookingListProvider = StateNotifierProvider<
    ManagerBookingListProvider, AsyncValue<List<Booking>>>((ref) {
  final token = ref.watch(tokenProvider);
  final provider = ManagerBookingListProvider(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadUserManageBookings();
  });
  return provider;
});
