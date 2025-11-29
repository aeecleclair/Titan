import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/ticketing/class/event.dart';

class EventNotifier extends StateNotifier<Event> {
  EventNotifier() : super(Event.empty());

  void setEvent(Event i) {
    state = i;
  }
}

final eventProvider = StateNotifierProvider<EventNotifier, Event>((ref) {
  return EventNotifier();
});
