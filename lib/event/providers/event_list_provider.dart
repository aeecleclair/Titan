import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // return await loadList(_eventRepository.getAllEvent);
    state = AsyncValue.data([
      Event(
        id: '4',
        name: 'HH USE',
        organizer: 'USE',
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 1)),
        location: 'Foyer',
        type: CalendarEventType.happyHour,
        allDay: false,
        fakeEnd: DateTime.now().add(const Duration(hours: 1)),
        fakeStart: DateTime.now(),
        recurrenceRule: '',
        description: 'test',
      ),
      Event(
        id: '4',
        name: 'HH USE',
        organizer: 'USE',
        start: DateTime.now().add(const Duration(days: 1)),
        end: DateTime.now().add(const Duration(days: 1, hours: 1)),
        location: 'Foyer',
        type: CalendarEventType.happyHour,
        allDay: false,
        fakeEnd: DateTime.now().add(const Duration(hours: 1)),
        fakeStart: DateTime.now(),
        recurrenceRule: '',
        description: 'test',
      ),
      Event(
        id: '4',
        name: 'HH USE',
        organizer: 'USE',
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(hours: 2)),
        location: 'Foyer',
        type: CalendarEventType.happyHour,
        allDay: false,
        fakeEnd: DateTime.now().add(const Duration(hours: 1)),
        fakeStart: DateTime.now(),
        recurrenceRule: '',
        description: 'test',
      ),
      Event(
        id: '4',
        name: 'HH USE',
        organizer: 'USE',
        start: DateTime.now().add(const Duration(hours: 3)),
        end: DateTime.now().add(const Duration(hours: 4)),
        location: 'Foyer',
        type: CalendarEventType.happyHour,
        allDay: false,
        fakeEnd: DateTime.now().add(const Duration(hours: 1)),
        fakeStart: DateTime.now(),
        recurrenceRule: '',
        description: 'test',
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
