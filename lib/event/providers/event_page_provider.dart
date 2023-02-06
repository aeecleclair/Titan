import 'package:flutter_riverpod/flutter_riverpod.dart';

enum EventPage {
  main,
  admin,
  addEditEventFromMain,
  eventDetailfromModuleFromMain,
  eventDetailfromModuleFromAdmin,
  eventDetailfromCalendar,
  addEditEventFromAdmin
}

class EventPageProvider extends StateNotifier<EventPage> {
  EventPageProvider() : super(EventPage.main);

  void setEventPage(EventPage i) {
    state = i;
  }
}

final eventPageProvider =
    StateNotifierProvider<EventPageProvider, EventPage>((ref) {
  return EventPageProvider();
});
