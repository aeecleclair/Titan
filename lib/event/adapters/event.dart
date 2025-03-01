import 'package:myecl/generated/openapi.swagger.dart';

extension $EventReturn on EventReturn {
  EventComplete toEventComplete() {
    return EventComplete(
        name: name,
        organizer: organizer,
        start: start,
        end: end,
        allDay: allDay,
        location: location,
        type: type,
        description: description,
        id: id,
        decision: decision,
        applicantId: applicantId);
  }

  EventBase toEventBase() {
    return EventBase(
        name: name,
        organizer: organizer,
        start: start,
        end: end,
        allDay: allDay,
        location: location,
        type: type,
        description: description,
        recurrenceRule: recurrenceRule);
  }
}
