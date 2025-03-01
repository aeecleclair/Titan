import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ConfirmedBookingListProvider
    extends ListNotifierAPI<BookingReturnSimpleApplicant> {
  final Openapi bookingRepository;
  ConfirmedBookingListProvider({required this.bookingRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<BookingReturnSimpleApplicant>>>
      loadConfirmedBooking() async {
    return await loadList(bookingRepository.bookingBookingsConfirmedGet);
  }

  Future<bool> addBooking(BookingReturnSimpleApplicant booking) async {
    return await localAdd(booking);
  }

  Future<bool> deleteBooking(BookingReturnSimpleApplicant booking) async {
    return await localDelete(
      (bookings, booking) =>
          bookings..removeWhere((element) => element.id == booking.id),
      booking,
    );
  }

  Future<bool> updateBooking(BookingReturnSimpleApplicant booking) async {
    return await localUpdate(
      (bookings, booking) =>
          bookings..[bookings.indexWhere((b) => b.id == booking.id)] = booking,
      booking,
    );
  }
}

final confirmedBookingListProvider = StateNotifierProvider<
    ConfirmedBookingListProvider,
    AsyncValue<List<BookingReturnSimpleApplicant>>>((ref) {
  final bookingRepository = ref.watch(repositoryProvider);
  final provider =
      ConfirmedBookingListProvider(bookingRepository: bookingRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadConfirmedBooking();
  });
  return provider;
});
