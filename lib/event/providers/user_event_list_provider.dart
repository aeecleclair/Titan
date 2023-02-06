import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/repositories/event_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class EventEventListProvider extends ListNotifier<Event> {
  final EventRepository _eventRepository = EventRepository();
  EventEventListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _eventRepository.setToken(token);
  }

  Future<AsyncValue<List<Event>>> loadConfirmedEvent(String id) async {
    return await loadList(() async => _eventRepository.getUserEventList(id));
  }


  Future<bool> addEvent(Event event) async {
    return await add(_eventRepository.createEvent, event);
  }

  Future<bool> updateEvent(Event event) async {
    return await update(
        _eventRepository.updateEvent,
        (events, event) =>
            events..[events.indexWhere((e) => e.id == event.id)] = event,
        event);
  }

  Future<bool> deleteEvent(Event event) async {
    return await delete(
        _eventRepository.deleteEvent,
        (events, event) => events..removeWhere((e) => e.id == event.id),
        event.id,
        event);
  }
}

final eventEventListProvider =
    StateNotifierProvider<EventEventListProvider, AsyncValue<List<Event>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final userId = ref.watch(idProvider);
  final provider = EventEventListProvider(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadConfirmedEvent(userId);
  });
  return provider;
});
