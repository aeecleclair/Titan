import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/repositories/event_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class EventListNotifier extends ListNotifier<Event> {
  final EventRepository _eventRepository = EventRepository();
  EventListNotifier(String token) : super(const AsyncValue.loading()) {
    _eventRepository.setToken(token);
  }

  Future<AsyncValue<List<Event>>> loadEventList() async {
    return await loadList(_eventRepository.getAllEvent);
    // state = AsyncValue.data([
    //   Event(
    //     description: "xdftghij",
    //     end: DateTime.now(),
    //     id: 'etrykhgfeqretyjhg',
    //     name: 'Test',
    //     organizer: 'zegtq',
    //     start: DateTime.now(),
    //     type: CalendarEventType.direction,
    //     allDay: true,
    //     fakeEnd: DateTime.now(),
    //     fakeStart: DateTime.now(),
    //     location: 'srfhf',
    //     recurrenceRule: '',
    //   ),
    //   Event(
    //     description: "jhvkjhvhv",
    //     end: DateTime.now().add(Duration(hours: 2)),
    //     id: 'fuhojnpokhfty',
    //     name: 'Test 2',
    //     organizer: 'zegtq',
    //     start: DateTime.now(),
    //     type: CalendarEventType.direction,
    //     allDay: false,
    //     fakeEnd: DateTime.now(),
    //     fakeStart: DateTime.now(),
    //     location: 'zoej(afklnbvze',
    //     recurrenceRule: "FREQ=WEEKLY;INTERVAL=1;BYDAY=FR,WE;UNTIL=20221231"
    //   ),
    // ]);
    // return state;
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

  Future<Event> findbyId(Object? id) async {
    return state.when(
      data: (data) {
        return data.firstWhere((element) => element.id == id,
            orElse: () => Event.empty());
      },
      loading: () {
        return Event.empty();
      },
      error: (error, stackTrace) {
        return Event.empty();
      },
    );
  }
}

final eventListProvider =
    StateNotifierProvider<EventListNotifier, AsyncValue<List<Event>>>((ref) {
  final token = ref.watch(tokenProvider);
  EventListNotifier notifier = EventListNotifier(token);
  notifier.loadEventList();
  return notifier;
});
