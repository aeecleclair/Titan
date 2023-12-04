import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class EventNotifier extends StateNotifier<EventReturn> {
  EventNotifier() : super(EventReturn.fromJson({}));

  void setEvent(EventReturn event) {
    state = event;
  }
}

final eventProvider = StateNotifierProvider<EventNotifier, EventReturn>((ref) {
  return EventNotifier();
});
