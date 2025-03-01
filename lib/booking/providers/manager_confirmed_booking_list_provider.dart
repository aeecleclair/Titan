import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ManagerConfirmedBookingListProvider
    extends ListNotifier2<BookingReturnSimpleApplicant> {
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
      (bookings, booking) =>
          bookings..removeWhere((element) => element.id == booking.id),
      booking,
    );
  }
}

final managerConfirmedBookingListProvider = StateNotifierProvider<
    ManagerConfirmedBookingListProvider,
    AsyncValue<List<BookingReturnSimpleApplicant>>>(
  (ref) {
    final bookingRepository = ref.watch(repositoryProvider);
    final provider = ManagerConfirmedBookingListProvider(
      bookingRepository: bookingRepository,
    );
    tokenExpireWrapperAuth(
      ref,
      () async {
        await provider.loadConfirmedBookingForManager();
      },
    );
    return provider;
  },
);
