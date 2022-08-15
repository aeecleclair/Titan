import 'package:myecl/booking/tools/functions.dart';

class Booking {
  late final String id;
  late final String reason;
  late final DateTime start;
  late final DateTime end;
  late final String note;
  late final String room;
  late final bool key;
  late final bool confirmed;
  late final bool multipleDay;
  late final bool recurring;

  Booking(
      {required this.id,
      required this.reason,
      required this.start,
      required this.end,
      required this.note,
      required this.room,
      required this.key,
      required this.confirmed,
      required this.multipleDay,
      required this.recurring});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    reason = json["reason"];
    start = DateTime.parse(json["start"]);
    end = DateTime.parse(json["end"]);
    note = json["note"];
    room = json["room"];
    key = json["key"];
    confirmed = json["confirmed"];
    multipleDay = json["multipleDay"];
    recurring = json["recurring"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["id"] = id;
    _data["reason"] = reason;
    _data["start"] = processDate(start);
    _data["end"] = processDate(end);
    _data["note"] = note;
    _data["room"] = room;
    _data["key"] = key;
    _data["confirmed"] = confirmed;
    _data["multipleDay"] = multipleDay;
    _data["recurring"] = recurring;
    return _data;
  }

  Booking copyWith(
      {id,
      reason,
      start,
      end,
      note,
      room,
      key,
      confirmed,
      multipleDay,
      recurring}) {
    return Booking(
        id: id ?? this.id,
        reason: reason ?? this.reason,
        start: start ?? this.start,
        end: end ?? this.end,
        note: note ?? this.note,
        room: room ?? this.room,
        key: key ?? this.key,
        confirmed: confirmed ?? this.confirmed,
        multipleDay: multipleDay ?? this.multipleDay,
        recurring: recurring ?? this.recurring);
  }
}
