import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class UserBookingListProvider extends ListNotifier<Booking> {
  final BookingRepository _bookingRepository = BookingRepository();
  UserBookingListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _bookingRepository.setToken(token);
  }

  Future<AsyncValue<List<Booking>>> loadUserBookings() async {
    return await loadList(() async => _bookingRepository.getConfirmedBookingList());
  }
}

final confirmedBookingListProvider =
    StateNotifierProvider<UserBookingListProvider, AsyncValue<List<Booking>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final provider = UserBookingListProvider(token: token);
  provider.loadUserBookings();
  return provider;
});
