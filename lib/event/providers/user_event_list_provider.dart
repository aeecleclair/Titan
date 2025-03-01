import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';

class EventEventListProvider extends ListNotifier2<EventReturn> {
  final Openapi eventRepository;
  EventEventListProvider({required this.eventRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<EventReturn>>> loadConfirmedEvent(
      String userId) async {
    return await loadList(() async =>
        eventRepository.calendarEventsUserApplicantIdGet(applicantId: userId));
  }

  Future<bool> addEvent(EventBase event) async {
    return await add(
        () => eventRepository.calendarEventsPost(body: event), event);
  }

  Future<bool> updateEvent(EventReturn event) async {
    return await update(
      () => eventRepository.calendarEventsEventIdPatch(
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
      event,
    );
  }

  Future<bool> deleteEvent(EventReturn event) async {
    return await delete(
      () => eventRepository.calendarEventsEventIdDelete(eventId: event.id),
      (events, event) => events..removeWhere((e) => e.id == event.id),
      event,
    );
  }
}

final eventEventListProvider = StateNotifierProvider.family<
    EventEventListProvider,
    AsyncValue<List<EventReturn>>,
    String>((ref, userId) {
  final eventRepository = ref.watch(repositoryProvider);
  return EventEventListProvider(eventRepository: eventRepository)
    ..loadConfirmedEvent(userId);
});
