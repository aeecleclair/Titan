import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/repositories/user_booking_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserBookingListProvider extends ListNotifier<Booking> {
  final UserBookingRepository userRepository;
  String userId = "";
  UserBookingListProvider({required this.userRepository})
      : super(const AsyncValue.loading()) {
    setId(userId);
  }

  void setId(String id) {
    userId = id;
  }

  Future<AsyncValue<List<Booking>>> loadUserBookings() async {
    return await loadList(() async => userRepository.getMyBookingList(userId));
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
  final userRepository = ref.watch(userBookingRepositoryProvider);
  final provider = UserBookingListProvider(userRepository: userRepository);
  tokenExpireWrapperAuth(ref, () async {
    final userId = ref.watch(idProvider);
    userId.whenData(
      (value) => provider.setId(value),
    );
    await provider.loadUserBookings();
  });
  return provider;
});
