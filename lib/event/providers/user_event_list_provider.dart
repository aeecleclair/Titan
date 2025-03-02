import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/event/adapters/event.dart';

class EventEventListProvider extends ListNotifierAPI<EventReturn> {
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
}

final eventEventListProvider = StateNotifierProvider.family<
    EventEventListProvider,
    AsyncValue<List<EventReturn>>,
    String>((ref, userId) {
  final eventRepository = ref.watch(repositoryProvider);
  return EventEventListProvider(eventRepository: eventRepository)
    ..loadConfirmedEvent(userId);
});
