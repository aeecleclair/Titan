import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/repositories/event_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class EventListNotifier extends ListNotifier<Event> {
  final EventRepository _eventRepository = EventRepository();
  EventListNotifier(String token) : super(const AsyncValue.loading()) {
    print(token);
    _eventRepository.setToken(token);
  }

  Future<AsyncValue<List<Event>>> loadEventList() async {
    // return await loadList(_eventRepository.getAllEvent);
    state = AsyncValue.data([
      Event(
        description: "xdftghij",
        end: DateTime.now().add(Duration(hours: 2)),
        id: 'etrykhgfeqretyjhg',
        name: 'Test',
        organizer: 'zegtq',
        place: 'rzeherh',
        recurrence: false,
        start: DateTime.now(),
        type: CalendarEventType.direction,
      ),
      Event(
        description: "jhvkjhvhv",
        end: DateTime.now().add(Duration(hours: 2)),
        id: 'fuhojnpokhfty',
        name: 'Test 2',
        organizer: 'zegtq',
        place: 'rzeherh',
        recurrence: false,
        start: DateTime.now(),
        type: CalendarEventType.direction,
      ),
    ]);
    return state;
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

final eventListProvider =
    StateNotifierProvider<EventListNotifier, AsyncValue<List<Event>>>((ref) {
  final token = ref.watch(tokenProvider);
  EventListNotifier notifier = EventListNotifier(token);
  notifier.loadEventList();
  print(notifier.state);
  return notifier;
});
