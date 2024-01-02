import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class EventListNotifier extends ListNotifier2<EventReturn> {
  final Openapi eventRepository;
  EventListNotifier({required this.eventRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<EventReturn>>> loadEventList() async {
    return await loadList(eventRepository.calendarEventsGet);
  }

  Future<bool> addEvent(EventReturn event) async {
    return await add(
        (event) async => eventRepository.calendarEventsPost(
                body: EventBase(
              name: event.name,
              organizer: event.organizer,
              start: event.start,
              end: event.end,
              allDay: event.allDay,
              location: event.location,
              type: event.type,
              description: event.description,
              recurrenceRule: event.recurrenceRule,
            )),
        event);
  }

  Future<bool> updateEvent(EventReturn event) async {
    return await update(
        (event) async => eventRepository.calendarEventsEventIdPatch(
            eventId: event.id,
            body: EventEdit(
              name: event.name,
              organizer: event.organizer,
              start: event.start,
              end: event.end,
              allDay: event.allDay,
              location: event.location,
              type: event.type,
              description: event.description,
              recurrenceRule: event.recurrenceRule,
            )),
        (events, event) =>
            events..[events.indexWhere((e) => e.id == event.id)] = event,
        event);
  }

  Future<bool> deleteEvent(EventReturn event) async {
    return await delete(
        (eventId) async =>
            eventRepository.calendarEventsEventIdDelete(eventId: eventId),
        (events, event) => events..removeWhere((e) => e.id == event.id),
        event.id,
        event);
  }

  Future<bool> toggleConfirmed(
      EventReturn event, AppUtilsTypesCalendarTypesDecision decision) async {
    return await update(
        (event) => eventRepository.calendarEventsEventIdReplyDecisionPatch(
            eventId: event.id, decision: decision),
        (events, event) =>
            events..[events.indexWhere((b) => b.id == event.id)] = event,
        event);
  }
}

final eventListProvider =
    StateNotifierProvider<EventListNotifier, AsyncValue<List<EventReturn>>>(
        (ref) {
  final eventRepository = ref.watch(repositoryProvider);
  EventListNotifier notifier =
      EventListNotifier(eventRepository: eventRepository);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadEventList();
  });
  return notifier;
});
