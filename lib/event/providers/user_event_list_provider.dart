import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/repositories/event_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class EventEventListProvider extends ListNotifier<Event> {
  final EventRepository _eventRepository = EventRepository();
  String userId = "";
  EventEventListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _eventRepository.setToken(token);
  }

  void setId(String id) {
    userId = id;
  }

  Future<AsyncValue<List<Event>>> loadConfirmedEvent() async {
    return await loadList(
        () async => _eventRepository.getUserEventList(userId));
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
    userId.whenData((value) async {
      provider.setId(value);
      await provider.loadConfirmedEvent();
    });
  });
  return provider;
});
