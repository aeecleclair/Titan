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
  late final Applicant applicant;

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
    required this.applicant,
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
    recurrenceRule = json['recurrence_rule'];
    applicant = Applicant.fromJson(json['applicant']);
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
    Applicant? applicant,
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
      applicant: applicant ?? this.applicant,
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
    applicant = Applicant.empty();
  }
}
