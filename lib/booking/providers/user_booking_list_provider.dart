import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/user_booking_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserBookingListProvider extends ListNotifier<Booking> {
  final UserBookingRepository _userRepository = UserBookingRepository();
  UserBookingListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _userRepository.setToken(token);
  }

  Future<AsyncValue<List<Booking>>> loadUserBookings() async {
    return await loadList(() async => _userRepository.getUserBookingList());
  }

  Future<bool> addBooking(Booking booking) async {
    return state.when(
        data: (bookings) async {
          bookings.add(booking);
          state = AsyncValue.data(bookings);
          return true;
        },
        loading: () async => false,
        error: (e, s) async => false);
  }

  Future<bool> updateBooking(Booking booking) async {
    return state.when(
        data: (bookings) async {
          final index = bookings.indexWhere((b) => b.id == booking.id);
          if (index != -1) {
            bookings[index] = booking;
            state = AsyncValue.data(bookings);
            return true;
          }
          return false;
        },
        loading: () async => false,
        error: (e, s) async => false);
  }

  Future<bool> deleteBooking(Booking booking) async {
    return state.when(
        data: (bookings) async {
          final index = bookings.indexWhere((b) => b.id == booking.id);
          if (index != -1) {
            bookings.removeAt(index);
            state = AsyncValue.data(bookings);
            return true;
          }
          return false;
        },
        loading: () async => false,
        error: (e, s) async => false);
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
