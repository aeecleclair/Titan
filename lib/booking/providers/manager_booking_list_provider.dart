import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/booking/adapters/booking.dart';

class ManagerBookingListProvider
    extends ListNotifierAPI<BookingReturnApplicant> {
  final Openapi bookingRepository;
  ManagerBookingListProvider({required this.bookingRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<BookingReturnApplicant>>>
      loadUserManageBookings() async {
    return await loadList(bookingRepository.bookingBookingsUsersMeManageGet);
  }

  Future<bool> updateBooking(BookingReturnApplicant booking) async {
    return await update(
      () => bookingRepository.bookingBookingsBookingIdPatch(
        bookingId: booking.id,
        body: booking.toBookingEdit(),
      ),
      (booking) => booking.id,
      booking,
    );
  }

  Future<bool> toggleConfirmed(
      BookingReturnApplicant booking, Decision decision) async {
    return await update(
      () => bookingRepository.bookingBookingsBookingIdReplyDecisionPatch(
          bookingId: booking.id, decision: decision),
      (booking) => booking.id,
      booking,
    );
  }
}

final managerBookingListProvider = StateNotifierProvider<
    ManagerBookingListProvider,
    AsyncValue<List<BookingReturnApplicant>>>((ref) {
  final bookingRepository = ref.watch(repositoryProvider);
  final provider =
      ManagerBookingListProvider(bookingRepository: bookingRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadUserManageBookings();
  });
  return provider;
});
