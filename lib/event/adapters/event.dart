import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

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
      applicantId: applicantId,
    );
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
      recurrenceRule: recurrenceRule,
    );
  }

  EventEdit toEventEdit() {
    return EventEdit(
      name: name,
      organizer: organizer,
      start: start,
      end: end,
      allDay: allDay,
      location: location,
      type: type,
      description: description,
      recurrenceRule: recurrenceRule,
    );
  }
}

extension $EventComplete on EventComplete {
  EventReturn toEventReturn() {
    return EventReturn(
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
      applicantId: applicantId,
      applicant: EmptyModels.empty<EventApplicant>(),
    );
  }
}
