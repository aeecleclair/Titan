import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/ticketing/class/event.dart';
import 'package:titan/ticketing/repositories/event_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class EventListNotifier extends ListNotifier<Event> {
  EventRepository repository = EventRepository();
  EventListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<Event>>> loadEvents() async {
    return await loadList(repository.getAllEvent);
  }

  Future<bool> addEvent(Event event) async {
    return await add(repository.addEvent, event);
  }

  Future<bool> updateEvent(Event event) async {
    return await update(
      repository.updateEvent,
      (events, event) =>
          events..[events.indexWhere((b) => b.id == event.id)] = event,
      event,
    );
  }

  Future<bool> deleteEvent(Event event) async {
    return await delete(
      repository.deleteEvent,
      (events, event) => events..removeWhere((b) => b.id == event.id),
      event.id,
      event,
    );
  }
}

final eventListProvider =
    StateNotifierProvider<EventListNotifier, AsyncValue<List<Event>>>((ref) {
      final token = ref.watch(tokenProvider);
      EventListNotifier notifier = EventListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadEvents();
      });
      return notifier;
    });
