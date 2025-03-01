import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ConfirmedEventListProvider extends ListNotifier2<EventComplete> {
  final Openapi eventRepository;
  ConfirmedEventListProvider({required this.eventRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<EventComplete>>> loadConfirmedEvent() async {
    return await loadList(eventRepository.calendarEventsConfirmedGet);
  }

  Future<bool> addEvent(EventComplete booking) async {
    return await localAdd(booking);
  }

  Future<bool> deleteEvent(EventComplete booking) async {
    return await localDelete(
      (bookings, booking) =>
          bookings..removeWhere((element) => element.id == booking.id),
      booking,
    );
  }
}

final confirmedEventListProvider =
    StateNotifierProvider<ConfirmedEventListProvider, AsyncValue<List<EventComplete>>>(
        (ref) {
  final eventRepository = ref.watch(repositoryProvider);
  final provider = ConfirmedEventListProvider(eventRepository: eventRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadConfirmedEvent();
  });
  return provider;
});
