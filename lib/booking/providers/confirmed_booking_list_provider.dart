import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

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
      (b) => b.id,
      booking.id,
    );
  }

  Future<bool> updateBooking(BookingReturnSimpleApplicant booking) async {
    return await localUpdate(
      (b) => b.id,
      booking,
    );
  }
}

final confirmedBookingListProvider = StateNotifierProvider<
    ConfirmedBookingListProvider,
    AsyncValue<List<BookingReturnSimpleApplicant>>>((ref) {
  final bookingRepository = ref.watch(repositoryProvider);
  return ConfirmedBookingListProvider(bookingRepository: bookingRepository)
    ..loadConfirmedBooking();
});
