import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/repositories/booking_repository.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ManagerBookingListProvider extends ListNotifier<Booking> {
  final BookingRepository bookingRepository;
  ManagerBookingListProvider({required this.bookingRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Booking>>> loadUserManageBookings() async {
    return await loadList(bookingRepository.getUserManageBookingList);
  }

  Future<bool> updateBooking(Booking booking) async {
    return await update(
      bookingRepository.updateBooking,
      (bookings, booking) =>
          bookings..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
      booking,
    );
  }

  Future<bool> toggleConfirmed(Booking booking, Decision decision) async {
    return await update(
      (booking) => bookingRepository.confirmBooking(booking, decision),
      (bookings, booking) =>
          bookings..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
      booking,
    );
  }
}

final managerBookingListProvider =
    StateNotifierProvider<
      ManagerBookingListProvider,
      AsyncValue<List<Booking>>
    >((ref) {
      final bookingRepository = ref.watch(bookingRepositoryProvider);
      final provider = ManagerBookingListProvider(
        bookingRepository: bookingRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadUserManageBookings();
      });
      return provider;
    });
