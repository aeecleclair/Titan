import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ManagerConfirmedBookingListProvider extends ListNotifier<Booking> {
  final BookingRepository _bookingRepository = BookingRepository();
  ManagerConfirmedBookingListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _bookingRepository.setToken(token);
  }

  Future<AsyncValue<List<Booking>>> loadConfirmedBookingForManager() async {
    return await loadList(
        () async => _bookingRepository.getUserManageConfirmedBookingList());
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
}

final managerConfirmedBookingListProvider = StateNotifierProvider<
    ManagerConfirmedBookingListProvider, AsyncValue<List<Booking>>>(
  (ref) {
    final token = ref.watch(tokenProvider);
    final provider = ManagerConfirmedBookingListProvider(token: token);
    tokenExpireWrapperAuth(
      ref,
      () async {
        await provider.loadConfirmedBookingForManager();
      },
    );
    return provider;
  },
);
