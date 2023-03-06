import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ConfirmedBookingListProvider extends ListNotifier<Booking> {
  final BookingRepository _bookingRepository = BookingRepository();
  ConfirmedBookingListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _bookingRepository.setToken(token);
  }

  Future<AsyncValue<List<Booking>>> loadConfirmedBooking() async {
    return await loadList(
        () async => _bookingRepository.getConfirmedBookingList());
  }

  Future<bool> addBooking(Booking booking) async {
    return await add((b) async => b, booking);
  }

  Future<bool> deleteBooking(Booking booking) async {
    return await delete(
        (_) async => true,
        (bookings, booking) =>
            bookings..removeWhere((element) => element.id == booking.id),
        booking.id,
        booking);
  }

  Future<bool> updateBooking(Booking booking) async {
    return await update(
        (_) async => true,
        (bookings, booking) => bookings
          ..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
        booking);
  }
}

final confirmedBookingListProvider = StateNotifierProvider<
    ConfirmedBookingListProvider, AsyncValue<List<Booking>>>((ref) {
  final token = ref.watch(tokenProvider);
  final provider = ConfirmedBookingListProvider(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadConfirmedBooking();
  });
  return provider;
});
