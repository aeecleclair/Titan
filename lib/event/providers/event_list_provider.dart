import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
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

  Future<bool> deleteEvent(EventReturn event) async {
    return await delete(
      () => eventRepository.calendarEventsEventIdDelete(eventId: event.id),
      (e) => e.id,
      event.id,
    );
  }

  Future<bool> toggleConfirmed(EventReturn event) async {
    return await update(
      () => eventRepository.calendarEventsEventIdReplyDecisionPatch(
          eventId: event.id, decision: event.decision),
      (event) => event.id,
      event,
    );
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
