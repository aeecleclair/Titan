import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/repositories/booking_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class UserBookingListProvider extends ListNotifier<Booking> {
  final BookingRepository bookingRepository;
  UserBookingListProvider({required this.bookingRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Booking>>> loadUserBookings() async {
    return await loadList(bookingRepository.getUserBookingList);
  }

  Future<bool> addBooking(Booking booking) async {
    return await add(bookingRepository.createBooking, booking);
  }

  Future<bool> updateBooking(Booking booking) async {
    return await update(
      bookingRepository.updateBooking,
      (bookings, booking) =>
          bookings..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
      booking,
    );
  }

  Future<bool> deleteBooking(Booking booking) async {
    return await delete(
      bookingRepository.deleteBooking,
      (bookings, booking) => bookings..removeWhere((i) => i.id == booking.id),
      booking.id,
      booking,
    );
  }
}

final userBookingListProvider =
    StateNotifierProvider<UserBookingListProvider, AsyncValue<List<Booking>>>((
      ref,
    ) {
      final bookingRepository = ref.watch(bookingRepositoryProvider);
      final provider = UserBookingListProvider(
        bookingRepository: bookingRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadUserBookings();
      });
      return provider;
    });
