import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/repositories/booking_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ConfirmedBookingListProvider extends ListNotifier<Booking> {
  final BookingRepository bookingRepository;
  ConfirmedBookingListProvider({required this.bookingRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Booking>>> loadConfirmedBooking() async {
    return await loadList(
      () async => bookingRepository.getConfirmedBookingList(),
    );
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
      booking,
    );
  }

  Future<bool> updateBooking(Booking booking) async {
    return await update(
      (_) async => true,
      (bookings, booking) =>
          bookings..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
      booking,
    );
  }
}

final confirmedBookingListProvider =
    StateNotifierProvider<
      ConfirmedBookingListProvider,
      AsyncValue<List<Booking>>
    >((ref) {
      final bookingRepository = ref.watch(bookingRepositoryProvider);
      final provider = ConfirmedBookingListProvider(
        bookingRepository: bookingRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadConfirmedBooking();
      });
      return provider;
    });
