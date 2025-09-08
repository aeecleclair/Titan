import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/event/class/event.dart';

class EventNotifier extends StateNotifier<Event> {
  EventNotifier() : super(Event.empty());

  void setEvent(Event event) {
    state = event;
  }

  void setRoom(String location) {
    state = state.copyWith(location: location);
  }
}

final eventProvider = StateNotifierProvider<EventNotifier, Event>((ref) {
  return EventNotifier();
});
