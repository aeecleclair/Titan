import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/providers/is_manager_provider.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/booking/repositories/user_booking_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_provider.dart';

class BookingListProvider extends ListNotifier<Booking> {
  final BookingRepository bookingRepository;
  final UserBookingRepository userRepository;
  BookingListProvider(
      {required this.bookingRepository, required this.userRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Booking>>> loadBookings() async {
    return await loadList(bookingRepository.getBookingList);
  }

  Future<AsyncValue<List<Booking>>> loadUserBookings(String userId) async {
    return await loadList(() async => userRepository.getMyBookingList(userId));
  }

  Future<bool> addBooking(Booking booking) async {
    return await add(bookingRepository.createBooking, booking);
  }

  Future<bool> updateBooking(Booking booking) async {
    return await update(
        bookingRepository.updateBooking,
        (bookings, booking) => bookings
          ..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
        booking);
  }

  Future<bool> deleteBooking(Booking booking) async {
    return await delete(
        bookingRepository.deleteBooking,
        (bookings, booking) => bookings..removeWhere((i) => i.id == booking.id),
        booking.id,
        booking);
  }

  Future<bool> toggleConfirmed(Booking booking, Decision decision) async {
    return await update(
        (booking) => bookingRepository.confirmBooking(booking, decision),
        (bookings, booking) => bookings
          ..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
        booking.copyWith(decision: decision));
  }
}

final bookingListProvider =
    StateNotifierProvider<BookingListProvider, AsyncValue<List<Booking>>>(
        (ref) {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  final userRepository = ref.watch(userBookingRepositoryProvider);
  final provider = BookingListProvider(
      bookingRepository: bookingRepository, userRepository: userRepository);
  final isManager = ref.watch(isManagerProvider);
  tokenExpireWrapperAuth(ref, () async {
    if (isManager) {
      await provider.loadBookings();
    } else {
      final userId = ref.watch(userProvider);
      await provider.loadUserBookings(userId.id);
    }
  });
  return provider;
});
