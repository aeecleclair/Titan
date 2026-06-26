import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class EventListNotifier extends ListNotifierAPI<EventCompleteTicketUrl> {
  Openapi get eventRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<EventCompleteTicketUrl>> build() {
    loadEventList();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<EventCompleteTicketUrl>>> loadEventList() async {
    return await loadList(eventRepository.calendarEventsGet);
  }

  Future<bool> addEvent(EventBaseCreation event) async {
    return await add(
      () => eventRepository.calendarEventsPost(body: event),
      event,
    );
  }

  Future<bool> updateEvent(EventCompleteTicketUrl event) async {
    return await update(
      () => eventRepository.calendarEventsEventIdPatch(
        eventId: event.id,
        body: EventEdit(
          name: event.name,
          start: event.start,
          end: event.end,
          allDay: event.allDay,
          location: event.location,
          description: event.description,
          recurrenceRule: event.recurrenceRule,
        ),
      ),
      (event) => event.id,
      event,
    );
  }

  Future<bool> deleteEvent(EventCompleteTicketUrl event) async {
    return await delete(
      () => eventRepository.calendarEventsEventIdDelete(eventId: event.id),
      (event) => event.id,
      event.id,
    );
  }

  Future<bool> toggleConfirmed(EventCompleteTicketUrl event) async {
    return await update(
      () => eventRepository.calendarEventsEventIdReplyDecisionPatch(
        eventId: event.id,
        decision: event.decision,
      ),
      (event) => event.id,
      event,
    );
  }
}

final eventListProvider =
    NotifierProvider<
      EventListNotifier,
      AsyncValue<List<EventCompleteTicketUrl>>
    >(EventListNotifier.new);
