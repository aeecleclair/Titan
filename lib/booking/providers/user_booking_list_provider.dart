import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/user_booking_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class UserBookingListProvider extends ListNotifier<Booking> {
  final UserBookingRepository _userRepository = UserBookingRepository();
  UserBookingListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _userRepository.setToken(token);
  }

  Future<AsyncValue<List<Booking>>> loadUserBookings(String userId) async {
    return await loadList(() async => _userRepository.getBookingList(userId));
  }

  Future<bool> addBooking(Booking booking) async {
    return state.when(
        data: (bookings) async {
          bookings.add(booking);
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
  final userId = ref.watch(idProvider);
  final provider = UserBookingListProvider(token: token);
  provider.loadUserBookings(userId);
  return provider;
});
