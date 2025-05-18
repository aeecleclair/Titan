import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/event/adapters/event.dart';

class EventListNotifier extends ListNotifierAPI<EventReturn> {
  final Openapi eventRepository;
  EventListNotifier({required this.eventRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<EventReturn>>> loadEventList() async {
    return await loadList(eventRepository.calendarEventsGet);
  }

  Future<bool> addEvent(EventBase event) async {
    return await add(
      () => eventRepository.calendarEventsPost(body: event),
      event,
    );
  }

  Future<bool> updateEvent(EventReturn event) async {
    return await update(
      () => eventRepository.calendarEventsEventIdPatch(
        eventId: event.id,
        body: event.toEventEdit(),
      ),
      (event) => event.id,
      event,
    );
  }

  Future<bool> deleteEvent(String eventId) async {
    return await delete(
      () => eventRepository.calendarEventsEventIdDelete(eventId: eventId),
      (e) => e.id,
      eventId,
    );
  }

  Future<bool> toggleConfirmed(EventReturn event) async {
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
    StateNotifierProvider<EventListNotifier, AsyncValue<List<EventReturn>>>(
        (ref) {
  final eventRepository = ref.watch(repositoryProvider);
  return EventListNotifier(eventRepository: eventRepository)..loadEventList();
});
