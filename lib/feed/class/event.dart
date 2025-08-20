import 'package:titan/tools/functions.dart';

class Event {
  late final String id;
  late final String name;
  late final DateTime start;
  late final DateTime end;
  late final bool allDay;
  late final String location;
  late final String recurrenceRule;
  late final DateTime? ticketUrlOpening;
  late final String associationId;
  late final String? ticketUrl;

  Event({
    required this.id,
    required this.name,
    required this.start,
    required this.end,
    required this.allDay,
    required this.location,
    required this.recurrenceRule,
    this.ticketUrlOpening,
    required this.associationId,
    this.ticketUrl,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    start = processDateFromAPI(json['start']);
    end = processDateFromAPI(json['end']);
    allDay = json['all_day'];
    location = json['location'];
    recurrenceRule = json['recurrence_rule'] ?? "";
    ticketUrlOpening = json['ticket_url_opening'] != null
        ? processDateFromAPI(json['ticket_url_opening'])
        : null;
    associationId = json['association_id'];
    ticketUrl = json['ticket_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['start'] = processDateToAPI(start);
    data['end'] = processDateToAPI(end);
    data['all_day'] = allDay;
    data['location'] = location;
    data['recurrence_rule'] = recurrenceRule;
    if (ticketUrlOpening != null) {
      data['ticket_url_opening'] = processDateToAPI(ticketUrlOpening!);
    }
    data['association_id'] = associationId;
    if (ticketUrl != null) {
      data['ticket_url'] = ticketUrl;
    }
    return data;
  }

  Event copyWith({
    String? name,
    DateTime? start,
    DateTime? end,
    String? location,
    bool? allDay,
    String? recurrenceRule,
    DateTime? ticketUrlOpening,
    String? associationId,
    String? ticketUrl,
    bool? hasRoom,
  }) {
    return Event(
      id: id,
      name: name ?? this.name,
      start: start ?? this.start,
      end: end ?? this.end,
      location: location ?? this.location,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      allDay: allDay ?? this.allDay,
      ticketUrlOpening: ticketUrlOpening ?? this.ticketUrlOpening,
      associationId: associationId ?? this.associationId,
      ticketUrl: ticketUrl ?? this.ticketUrl,
    );
  }

  Event.empty() {
    id = '';
    name = '';
    start = DateTime.now();
    end = DateTime.now();
    allDay = false;
    location = '';
    recurrenceRule = '';
    ticketUrlOpening = null;
    associationId = '';
    ticketUrl = null;
  }

  @override
  String toString() {
    return 'Event{name: $name, start: $start, end: $end, allDay: $allDay, location: $location, recurrenceRule: $recurrenceRule, ticketUrlOpening: $ticketUrlOpening, associationId: $associationId, ticketUrl: $ticketUrl}';
  }
}
