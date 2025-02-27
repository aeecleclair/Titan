import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ConfirmedBookingListProvider extends ListNotifier2<BookingReturn> {
  final Openapi bookingRepository;
  ConfirmedBookingListProvider({required this.bookingRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<BookingReturn>>> loadConfirmedBooking() async {
    // return await loadList(bookingRepository.bookingBookingsConfirmedGet);
    return state;
  }
}

final confirmedBookingListProvider = StateNotifierProvider<
    ConfirmedBookingListProvider, AsyncValue<List<BookingReturn>>>((ref) {
  final bookingRepository = ref.watch(repositoryProvider);
  final provider =
      ConfirmedBookingListProvider(bookingRepository: bookingRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadConfirmedBooking();
  });
  return provider;
});
