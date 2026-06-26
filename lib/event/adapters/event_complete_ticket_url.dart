import 'package:titan/generated/openapi.swagger.dart';

extension $EventCompleteTicketUrl on EventCompleteTicketUrl {
  EventBaseCreation toEventBaseCreation() {
    return EventBaseCreation(
      name: name,
      start: start,
      end: end,
      allDay: allDay,
      location: location,
      description: description,
      recurrenceRule: recurrenceRule,
      notification: notification,
      associationId: associationId,
    );
  }
}
