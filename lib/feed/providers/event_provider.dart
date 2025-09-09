import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/feed/class/event.dart';
import 'package:titan/feed/repositories/event_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class EventNotifier extends SingleNotifier<Event> {
  final EventRepository eventRepository;
  EventNotifier({required this.eventRepository})
    : super(const AsyncValue.loading());

  Future<Event> addEvent(Event event) async {
    return await eventRepository.createEvent(event);
  }

  void fakeLoad() {
    state = AsyncValue.data(Event.empty());
  }

  void setEvent(Event event) {
    state = AsyncValue.data(event);
  }
}

final eventProvider = StateNotifierProvider<EventNotifier, AsyncValue<Event>>((
  ref,
) {
  final token = ref.watch(tokenProvider);
  final eventRepository = EventRepository()..setToken(token);
  EventNotifier eventListNotifier = EventNotifier(
    eventRepository: eventRepository,
  )..fakeLoad();
  return eventListNotifier;
});
