import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/class/event.dart';
import 'package:titan/feed/repositories/event_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class AssociationEventsListNotifier extends ListNotifier<Event> {
  final EventRepository eventsRepository;
  AsyncValue<List<Event>> allNews = const AsyncValue.loading();
  AssociationEventsListNotifier({required this.eventsRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Event>>> loadAssociationEventList(
    String associationId,
  ) async {
    return allNews = await loadList(
      () => eventsRepository.getAssociationEventList(associationId),
    );
  }

  Future<bool> updateEvent(Event event) async {
    return await update(
      (event) => eventsRepository.updateEvent(event),
      (eventList, event) =>
          eventList..[eventList.indexWhere((d) => d.id == event.id)] = event,
      event,
    );
  }

  Future<bool> deleteEvent(Event event) async {
    return await update(
      (event) => eventsRepository.deleteEvent(event.id),
      (eventList, event) => eventList..removeWhere((d) => d.id == event.id),
      event,
    );
  }
}

final associationEventsListProvider =
    StateNotifierProvider<
      AssociationEventsListNotifier,
      AsyncValue<List<Event>>
    >((ref) {
      final token = ref.watch(tokenProvider);
      final eventsRepository = EventRepository()..setToken(token);
      AssociationEventsListNotifier newsListNotifier =
          AssociationEventsListNotifier(eventsRepository: eventsRepository);
      return newsListNotifier;
    });
