import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class BookingListProvider extends ListNotifier2<BookingReturnApplicant> {
  final Openapi bookingRepository;
  BookingListProvider({required this.bookingRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<BookingReturnApplicant>>> loadBookings() async {
    return await loadList(bookingRepository.bookingBookingsUsersMeManageGet);
  }
}

final adminBookingListProvider = StateNotifierProvider<BookingListProvider,
    AsyncValue<List<BookingReturnApplicant>>>((ref) {
  final bookingRepository = ref.watch(repositoryProvider);
  final provider = BookingListProvider(bookingRepository: bookingRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadBookings();
  });
  return provider;
});
