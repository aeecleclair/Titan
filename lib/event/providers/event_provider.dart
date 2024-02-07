import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/class/event.dart';

class EventNotifier extends StateNotifier<Event> {
  EventNotifier() : super(Event.empty());

  void setEvent(Event event) {
    state = event;
  }

  void setRoom(String location, String roomId) {
    state = state.copyWith(location: location, roomId: roomId);
  }
}

final eventProvider = StateNotifierProvider<EventNotifier, Event>((ref) {
  return EventNotifier();
});
