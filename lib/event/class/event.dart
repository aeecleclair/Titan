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
  late final String place;
  late final CalendarEventType type;
  late final String description;
  late final bool recurrence;
  late final DateTime? recurrenceEndDate;
  late final String? recurrenceRule;

  Event({
    required this.id,
    required this.name,
    required this.organizer,
    required this.start,
    required this.end,
    required this.place,
    required this.type,
    required this.description,
    required this.recurrence,
    this.recurrenceEndDate,
    this.recurrenceRule,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    organizer = json['organizer'];
    start = DateTime.parse(json['start']);
    end = DateTime.parse(json['end']);
    place = json['place'];
    type = stringToCalendarEventType(json['type']);
    description = json['description'];
    recurrence = json['recurrence'];
    recurrenceEndDate = json['recurrence_end_date'] != null
        ? DateTime.parse(json['recurrence_end_date'])
        : null;
    recurrenceRule = json['recurrence_rule'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['organizer'] = organizer;
    data['start'] = processDateToAPI(start);
    data['end'] = processDateToAPI(end);
    data['place'] = place;
    data['type'] = calendarEventTypeToString(type);
    data['description'] = description;
    data['recurrence'] = recurrence;
    data['recurrence_end_date'] =
        recurrenceEndDate != null ? processDateToAPI(recurrenceEndDate!) : null;
    data['recurrence_rule'] = recurrenceRule;
    return data;
  }

  Event.copyWith({
    String? id,
    String? name,
    String? organizer,
    DateTime? start,
    DateTime? end,
    String? place,
    CalendarEventType? type,
    String? description,
    bool? recurrence,
    DateTime? recurrenceEndDate,
    String? recurrenceRule,
  }) {
    this.id = id ?? this.id;
    this.name = name ?? this.name;
    this.organizer = organizer ?? this.organizer;
    this.start = start ?? this.start;
    this.end = end ?? this.end;
    this.place = place ?? this.place;
    this.type = type ?? this.type;
    this.description = description ?? this.description;
    this.recurrence = recurrence ?? this.recurrence;
    this.recurrenceEndDate = recurrenceEndDate ?? this.recurrenceEndDate;
    this.recurrenceRule = recurrenceRule ?? this.recurrenceRule;
  }

  Event.empty() {
    id = '';
    name = '';
    organizer = '';
    start = DateTime.now();
    end = DateTime.now();
    place = '';
    type = CalendarEventType.eventAE;
    description = '';
    recurrence = false;
    recurrenceEndDate = null;
    recurrenceRule = null;
  }
}
