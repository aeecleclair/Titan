import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/booking/adapters/booking_return_applicant.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ManagerBookingListProvider
    extends ListNotifierAPI<BookingReturnApplicant> {
  Openapi get bookingRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<BookingReturnApplicant>> build() {
    loadUserManageBookings();
    return const AsyncValue.loading();
  }

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
    BookingReturnApplicant booking,
    Decision decision,
  ) async {
    return await update(
      () => bookingRepository.bookingBookingsBookingIdReplyDecisionPatch(
        bookingId: booking.id,
        decision: decision,
      ),
      (booking) => booking.id,
      booking,
    );
  }
}

final managerBookingListProvider =
    NotifierProvider<
      ManagerBookingListProvider,
      AsyncValue<List<BookingReturnApplicant>>
    >(ManagerBookingListProvider.new);
