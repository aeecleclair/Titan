import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class EventNotifier extends Notifier<EventCompleteTicketUrl> {
  @override
  EventCompleteTicketUrl build() {
    return EventCompleteTicketUrl.fromJson({});
  }

  void setEvent(EventCompleteTicketUrl event) {
    state = event;
  }

  void setRoom(String location) {
    state = state.copyWith(location: location);
  }
}

final eventProvider = NotifierProvider<EventNotifier, EventCompleteTicketUrl>(
  EventNotifier.new,
);
