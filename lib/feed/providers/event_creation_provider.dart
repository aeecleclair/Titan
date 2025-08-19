import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/feed/class/event_creation.dart';
import 'package:titan/feed/repositories/event_creation_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class EventCreationNotifier extends SingleNotifier<EventCreation> {
  final EventCreationRepository eventRepository;
  EventCreationNotifier({required this.eventRepository})
    : super(const AsyncValue.loading());

    void fakeLoad() {
      state = AsyncValue.data(EventCreation.empty());
    }

  Future<bool> addEvent(EventCreation event) async {
    return await add(eventRepository.createEvent, event);
  }
}

final eventCreationProvider =
    StateNotifierProvider<EventCreationNotifier, AsyncValue<EventCreation>>((
      ref,
    ) {
      final eventRepository = ref.watch(eventCreationRepositoryProvider);
      EventCreationNotifier notifier = EventCreationNotifier(
        eventRepository: eventRepository,
      )..fakeLoad();
      return notifier;
    });
