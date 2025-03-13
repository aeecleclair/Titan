import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class ManagerConfirmedBookingListProvider
    extends ListNotifierAPI<BookingReturnSimpleApplicant> {
  final Openapi bookingRepository;
  ManagerConfirmedBookingListProvider({required this.bookingRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<BookingReturnSimpleApplicant>>>
      loadConfirmedBookingForManager() async {
    return await loadList(
      bookingRepository.bookingBookingsConfirmedGet,
    );
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
}

final managerConfirmedBookingListProvider = StateNotifierProvider<
    ManagerConfirmedBookingListProvider,
    AsyncValue<List<BookingReturnSimpleApplicant>>>(
  (ref) {
    final bookingRepository = ref.watch(repositoryProvider);
    return ManagerConfirmedBookingListProvider(
      bookingRepository: bookingRepository,
    )..loadConfirmedBookingForManager();
  },
);
