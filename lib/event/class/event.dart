import 'package:myecl/event/tools/functions.dart';
import 'package:myecl/tools/functions.dart';

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
  late final String? recurrenceRule;

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
    this.recurrenceRule,
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
    return data;
  }

  Event.copyWith({
    String? id,
    String? name,
    String? organizer,
    DateTime? start,
    DateTime? end,
    String? location,
    CalendarEventType? type,
    String? description,
    String? recurrenceRule,
  }) {
    this.id = id ?? this.id;
    this.name = name ?? this.name;
    this.organizer = organizer ?? this.organizer;
    this.start = start ?? this.start;
    this.end = end ?? this.end;
    this.location = location ?? this.location;
    this.type = type ?? this.type;
    this.description = description ?? this.description;
    this.recurrenceRule = recurrenceRule ?? this.recurrenceRule;
  }

  Event.empty() {
    id = '';
    name = '';
    organizer = '';
    start = DateTime.now();
    end = DateTime.now();
    location = '';
    type = CalendarEventType.eventAE;
    description = '';
    recurrenceRule = null;
  }
}
