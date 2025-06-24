import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/event/repositories/event_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class EventListNotifier extends ListNotifier<Event> {
  final EventRepository eventRepository;
  EventListNotifier({required this.eventRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Event>>> loadEventList() async {
    return await loadList(eventRepository.getAllEvent);
  }

  Future<bool> addEvent(Event event) async {
    return await add(eventRepository.createEvent, event);
  }

  Future<bool> updateEvent(Event event) async {
    return await update(
      eventRepository.updateEvent,
      (events, event) =>
          events..[events.indexWhere((e) => e.id == event.id)] = event,
      event,
    );
  }

  Future<bool> deleteEvent(Event event) async {
    return await delete(
      eventRepository.deleteEvent,
      (events, event) => events..removeWhere((e) => e.id == event.id),
      event.id,
      event,
    );
  }

  Future<bool> toggleConfirmed(Event event) async {
    return await update(
      (event) => eventRepository.confirmEvent(event),
      (events, event) =>
          events..[events.indexWhere((b) => b.id == event.id)] = event,
      event,
    );
  }
}

final eventListProvider =
    StateNotifierProvider<EventListNotifier, AsyncValue<List<Event>>>((ref) {
      final eventRepository = ref.watch(eventRepositoryProvider);
      EventListNotifier notifier = EventListNotifier(
        eventRepository: eventRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadEventList();
      });
      return notifier;
    });
