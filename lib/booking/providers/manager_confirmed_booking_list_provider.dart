import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/booking/repositories/booking_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ManagerConfirmedBookingListProvider extends ListNotifier<Booking> {
  final BookingRepository bookingRepository;
  ManagerConfirmedBookingListProvider({required this.bookingRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Booking>>> loadConfirmedBookingForManager() async {
    return await loadList(
      () async => bookingRepository.getUserManageConfirmedBookingList(),
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
}

final managerConfirmedBookingListProvider =
    StateNotifierProvider<
      ManagerConfirmedBookingListProvider,
      AsyncValue<List<Booking>>
    >((ref) {
      final bookingRepository = ref.watch(bookingRepositoryProvider);
      final provider = ManagerConfirmedBookingListProvider(
        bookingRepository: bookingRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadConfirmedBookingForManager();
      });
      return provider;
    });
