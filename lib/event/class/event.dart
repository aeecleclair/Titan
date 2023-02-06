import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/class/applicant.dart';

enum CalendarEventType {
  eventAE,
  eventUSE,
  happyHour,
  direction,
  nightParty,
  other
}

class Event {
  late final String id;
  late final String name;
  late final String organizer;
  late final DateTime start;
  late final DateTime end;
  late final bool allDay;
  late final String location;
  late final CalendarEventType type;
  late final String description;
  late final String recurrenceRule;
  late final String applicantId;
  late final Applicant applicant;
  late final Decision decision;
  late final String roomId;

  Event({
    required this.id,
    required this.name,
    required this.organizer,
    required this.start,
    required this.end,
    required this.location,
    required this.type,
    required this.description,
    required this.allDay,
    required this.recurrenceRule,
    required this.applicantId,
    required this.applicant,
    required this.decision,
    required this.roomId,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    organizer = json['organizer'];
    start = DateTime.parse(json['start']);
    end = DateTime.parse(json['end']);
    allDay = json['all_day'];
    location = json['location'];
    type = stringToCalendarEventType(json['type']);
    description = json['description'];
    recurrenceRule = json['recurrence_rule'] ?? "";
    applicantId = json['applicant_id'];
    applicant = json['applicant'] != null ? Applicant.fromJson(json['applicant']) : Applicant.empty().copyWith(id: applicantId);
    decision = stringToDecision(json['decision']);
    roomId = json['room_id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['organizer'] = organizer;
    data['start'] = processDateToAPI(start);
    data['end'] = processDateToAPI(end);
    data['all_day'] = allDay;
    data['location'] = location;
    data['type'] = calendarEventTypeToString(type);
    data['description'] = description;
    data['recurrence_rule'] = recurrenceRule;
    data['applicant_id'] = applicant.id;
    data['decision'] = decisionToString(decision);
    data['room_id'] = roomId;
    return data;
  }

  Event copyWith({
    String? id,
    String? name,
    String? organizer,
    DateTime? start,
    DateTime? end,
    String? location,
    CalendarEventType? type,
    String? description,
    bool? allDay,
    String? recurrenceRule,
    String? applicantId,
    Applicant? applicant,
    Decision? decision,
    String? roomId,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      organizer: organizer ?? this.organizer,
      start: start ?? this.start,
      end: end ?? this.end,
      location: location ?? this.location,
      type: type ?? this.type,
      description: description ?? this.description,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      allDay: allDay ?? this.allDay,
      applicantId: applicantId ?? this.applicantId,
      applicant: applicant ?? this.applicant,
      decision: decision ?? this.decision,
      roomId: roomId ?? this.roomId,
    );
  }

  Event.empty() {
    id = '';
    name = '';
    organizer = '';
    start = DateTime.now();
    end = DateTime.now();
    allDay = false;
    location = '';
    type = CalendarEventType.eventAE;
    description = '';
    recurrenceRule = '';
    applicantId = '';
    applicant = Applicant.empty();
    decision = Decision.pending;
    roomId = '';
  }
}
