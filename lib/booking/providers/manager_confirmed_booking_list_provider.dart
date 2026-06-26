import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ManagerConfirmedBookingListProvider
    extends ListNotifierAPI<BookingReturnSimpleApplicant> {
  Openapi get bookingRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<BookingReturnSimpleApplicant>> build() {
    loadConfirmedBookingForManager();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<BookingReturnSimpleApplicant>>>
  loadConfirmedBookingForManager() async {
    return await loadList(bookingRepository.bookingBookingsConfirmedGet);
  }

  Future<bool> addBooking(BookingReturnSimpleApplicant booking) async {
    return await localAdd(booking);
  }

  Future<bool> deleteBooking(BookingReturnSimpleApplicant booking) async {
    return await localDelete((booking) => booking.id, booking.id);
  }
}

final managerConfirmedBookingListProvider =
    NotifierProvider<
      ManagerConfirmedBookingListProvider,
      AsyncValue<List<BookingReturnSimpleApplicant>>
    >(ManagerConfirmedBookingListProvider.new);
