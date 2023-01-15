import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/repositories/event_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ConfirmedEventListProvider extends ListNotifier<Event> {
  final EventRepository _bookingRepository = EventRepository();
  ConfirmedEventListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _bookingRepository.setToken(token);
  }

  Future<AsyncValue<List<Event>>> loadConfirmedEvent() async {
    return await loadList(_bookingRepository.getConfirmedEventList);
  }

  Future<bool> addEvent(Event booking) async {
    return await add((b) async => b, booking);
  }

  Future<bool> deleteEvent(Event booking) async {
    return await delete(
        (_) async => true,
        (bookings, booking) =>
            bookings..removeWhere((element) => element.id == booking.id),
        booking.id,
        booking);
  }
}

final confirmedEventListProvider = StateNotifierProvider<
    ConfirmedEventListProvider, AsyncValue<List<Event>>>((ref) {
  final token = ref.watch(tokenProvider);
  final provider = ConfirmedEventListProvider(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadConfirmedEvent();
  });
  return provider;
});
