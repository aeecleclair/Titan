import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class EventNotifier extends StateNotifier<EventReturn> {
  EventNotifier() : super(EmptyModels.empty<EventReturn>());

  void setEvent(EventReturn event) {
    state = event;
  }

  void setRoom(String location) {
    state = state.copyWith(location: location);
  }
}

final eventProvider = StateNotifierProvider<EventNotifier, EventReturn>((ref) {
  return EventNotifier();
});
