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
          id: 'rthryuk',
          name: 'HH USE',
          organizer: 'USE',
          start: DateTime.now(),
          end: DateTime.now().add(const Duration(hours: 2)),
          location: 'Foyer',
          type: CalendarEventType.eventUSE,
          description:
              'Culpa est ex irure amet sunt officia ex qui. Amet eiusmod nulla cillum aliqua enim esse nulla eu ex est ipsum aliquip. Culpa tempor aliquip sunt veniam incididunt sunt. Id ad minim culpa dolor dolor quis irure non tempor voluptate excepteur eu. Mollit magna in deserunt elit dolore culpa ut excepteur. Dolor quis cupidatat amet pariatur eu aliqua aute. Duis dolore cupidatat elit tempor exercitation aliqua nulla.',
          allDay: false,
          recurrenceRule: ''),
      Event(
          id: 'rthryuk',
          name: 'HH USE',
          organizer: 'USE',
          start: DateTime.now().add(const Duration(days: 2)),
          end: DateTime.now().add(const Duration(days: 2, hours: 2)),
          location: 'Foyer',
          type: CalendarEventType.eventUSE,
          description:
              'Culpa est ex irure amet sunt officia ex qui. Amet eiusmod nulla cillum aliqua enim esse nulla eu ex est ipsum aliquip. Culpa tempor aliquip sunt veniam incididunt sunt. Id ad minim culpa dolor dolor quis irure non tempor voluptate excepteur eu. Mollit magna in deserunt elit dolore culpa ut excepteur. Dolor quis cupidatat amet pariatur eu aliqua aute. Duis dolore cupidatat elit tempor exercitation aliqua nulla.',
          allDay: false,
          recurrenceRule: ''),
      Event(
          id: 'rthryuk',
          name: 'HH USE',
          organizer: 'USE',
          start: DateTime.now().add(const Duration(days: 2)),
          end: DateTime.now().add(const Duration(days: 2, hours: 2)),
          location: 'Foyer',
          type: CalendarEventType.eventUSE,
          description:
              'Culpa est ex irure amet sunt officia ex qui. Amet eiusmod nulla cillum aliqua enim esse nulla eu ex est ipsum aliquip. Culpa tempor aliquip sunt veniam incididunt sunt. Id ad minim culpa dolor dolor quis irure non tempor voluptate excepteur eu. Mollit magna in deserunt elit dolore culpa ut excepteur. Dolor quis cupidatat amet pariatur eu aliqua aute. Duis dolore cupidatat elit tempor exercitation aliqua nulla.',
          allDay: false,
          recurrenceRule: ''),
      Event(
          id: 'rthryuk',
          name: 'HH USE',
          organizer: 'USE',
          start: DateTime.now().add(const Duration(days: 3)),
          end: DateTime.now().add(const Duration(days: 3, hours: 2)),
          location: 'Foyer',
          type: CalendarEventType.eventUSE,
          description:
              'Culpa est ex irure amet sunt officia ex qui. Amet eiusmod nulla cillum aliqua enim esse nulla eu ex est ipsum aliquip. Culpa tempor aliquip sunt veniam incididunt sunt. Id ad minim culpa dolor dolor quis irure non tempor voluptate excepteur eu. Mollit magna in deserunt elit dolore culpa ut excepteur. Dolor quis cupidatat amet pariatur eu aliqua aute. Duis dolore cupidatat elit tempor exercitation aliqua nulla.',
          allDay: false,
          recurrenceRule: ''),
      Event(
          id: 'rthryuk',
          name: 'HH USE',
          organizer: 'USE',
          start: DateTime.now().add(const Duration(days: 3)),
          end: DateTime.now().add(const Duration(days: 3, hours: 2)),
          location: 'Foyer',
          type: CalendarEventType.eventUSE,
          description:
              'Culpa est ex irure amet sunt officia ex qui. Amet eiusmod nulla cillum aliqua enim esse nulla eu ex est ipsum aliquip. Culpa tempor aliquip sunt veniam incididunt sunt. Id ad minim culpa dolor dolor quis irure non tempor voluptate excepteur eu. Mollit magna in deserunt elit dolore culpa ut excepteur. Dolor quis cupidatat amet pariatur eu aliqua aute. Duis dolore cupidatat elit tempor exercitation aliqua nulla.',
          allDay: false,
          recurrenceRule: ''),
      Event(
          id: 'rthryuk',
          name: 'HH USE',
          organizer: 'USE',
          start: DateTime.now().add(const Duration(days: 3)),
          end: DateTime.now().add(const Duration(days: 3, hours: 2)),
          location: 'Foyer',
          type: CalendarEventType.eventUSE,
          description:
              'Culpa est ex irure amet sunt officia ex qui. Amet eiusmod nulla cillum aliqua enim esse nulla eu ex est ipsum aliquip. Culpa tempor aliquip sunt veniam incididunt sunt. Id ad minim culpa dolor dolor quis irure non tempor voluptate excepteur eu. Mollit magna in deserunt elit dolore culpa ut excepteur. Dolor quis cupidatat amet pariatur eu aliqua aute. Duis dolore cupidatat elit tempor exercitation aliqua nulla.',
          allDay: false,
          recurrenceRule: ''),
      Event(
          id: 'rthryuk',
          name: 'HH USE',
          organizer: 'USE',
          start: DateTime.now().add(const Duration(days: 3)),
          end: DateTime.now().add(const Duration(days: 3, hours: 2)),
          location: 'Foyer',
          type: CalendarEventType.eventUSE,
          description:
              'Culpa est ex irure amet sunt officia ex qui. Amet eiusmod nulla cillum aliqua enim esse nulla eu ex est ipsum aliquip. Culpa tempor aliquip sunt veniam incididunt sunt. Id ad minim culpa dolor dolor quis irure non tempor voluptate excepteur eu. Mollit magna in deserunt elit dolore culpa ut excepteur. Dolor quis cupidatat amet pariatur eu aliqua aute. Duis dolore cupidatat elit tempor exercitation aliqua nulla.',
          allDay: false,
          recurrenceRule: ''),
      Event(
          id: 'rthryuk',
          name: 'HH USE',
          organizer: 'USE',
          start: DateTime.now().add(const Duration(days: 3)),
          end: DateTime.now().add(const Duration(days: 3, hours: 2)),
          location: 'Foyer',
          type: CalendarEventType.eventUSE,
          description:
              'Culpa est ex irure amet sunt officia ex qui. Amet eiusmod nulla cillum aliqua enim esse nulla eu ex est ipsum aliquip. Culpa tempor aliquip sunt veniam incididunt sunt. Id ad minim culpa dolor dolor quis irure non tempor voluptate excepteur eu. Mollit magna in deserunt elit dolore culpa ut excepteur. Dolor quis cupidatat amet pariatur eu aliqua aute. Duis dolore cupidatat elit tempor exercitation aliqua nulla.',
          allDay: false,
          recurrenceRule: ''),
      Event(
          id: 'rthryuk',
          name: 'HH USE',
          organizer: 'USE',
          start: DateTime.now().add(const Duration(days: 3)),
          end: DateTime.now().add(const Duration(days: 3, hours: 2)),
          location: 'Foyer',
          type: CalendarEventType.eventUSE,
          description:
              'Culpa est ex irure amet sunt officia ex qui. Amet eiusmod nulla cillum aliqua enim esse nulla eu ex est ipsum aliquip. Culpa tempor aliquip sunt veniam incididunt sunt. Id ad minim culpa dolor dolor quis irure non tempor voluptate excepteur eu. Mollit magna in deserunt elit dolore culpa ut excepteur. Dolor quis cupidatat amet pariatur eu aliqua aute. Duis dolore cupidatat elit tempor exercitation aliqua nulla.',
          allDay: false,
          recurrenceRule: ''),
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
