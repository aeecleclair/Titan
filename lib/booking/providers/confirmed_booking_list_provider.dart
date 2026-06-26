import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ConfirmedBookingListProvider
    extends ListNotifierAPI<BookingReturnSimpleApplicant> {
  Openapi get bookingRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<BookingReturnSimpleApplicant>> build() {
    loadConfirmedBooking();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<BookingReturnSimpleApplicant>>>
  loadConfirmedBooking() async {
    return await loadList(bookingRepository.bookingBookingsConfirmedGet);
  }

  Future<bool> addBooking(BookingReturnSimpleApplicant booking) async {
    return await localAdd(booking);
  }

  Future<bool> deleteBooking(BookingReturnSimpleApplicant booking) async {
    return await localDelete((booking) => booking.id, booking.id);
  }

  Future<bool> updateBooking(BookingReturnSimpleApplicant booking) async {
    return await localUpdate((booking) => booking.id, booking);
  }
}

final confirmedBookingListProvider =
    NotifierProvider<
      ConfirmedBookingListProvider,
      AsyncValue<List<BookingReturnSimpleApplicant>>
    >(ConfirmedBookingListProvider.new);
