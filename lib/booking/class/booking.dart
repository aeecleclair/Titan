import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/class/applicant.dart';

enum Decision { approved, declined, pending }

class Booking {
  late final String id;
  late final String reason;
  late final DateTime start;
  late final DateTime end;
  late final String note;
  late final Room room;
  late final bool key;
  late final Decision decision;
  late final String recurrenceRule;
  late final String entity;
  late final Applicant applicant;
  late final String applicantId;

  Booking(
      {required this.id,
      required this.reason,
      required this.start,
      required this.end,
      required this.note,
      required this.room,
      required this.key,
      required this.decision,
      required this.recurrenceRule,
      required this.entity,
      required this.applicant,
      required this.applicantId});

  static Booking fromJson(Map<String, dynamic> json) {
    Booking booking = Booking(
      id: json["id"],
      reason: json["reason"],
      start: DateTime.parse(json["start"]),
      end: DateTime.parse(json["end"]),
      note: json["note"],
      room: Room.fromJson(json["room"]),
      key: json["key"],
      decision: stringToDecision(json["decision"]),
      recurrenceRule: json["recurrence_rule"] ?? "",
      entity: json["entity"] ?? "",
      applicantId: json["applicant_id"],
      applicant: json["applicant"] != null
          ? Applicant.fromJson(json["applicant"])
          : Applicant.empty().copyWith(id: json["applicant_id"]),
    );
    return booking.copyWith(end: getTrueEnd(booking));
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["reason"] = reason;
    data["start"] = processDateToAPI(start);
    data["end"] = processDateToAPI(end);
    data["note"] = note;
    data["room_id"] = room.id;
    data["key"] = key;
    data["decision"] = decision.name;
    data["recurrence_rule"] = recurrenceRule;
    data["entity"] = entity;
    data["applicant_id"] = applicantId;
    return data;
  }

  Booking copyWith(
      {id,
      reason,
      start,
      end,
      note,
      room,
      key,
      decision,
      recurrenceRule,
      entity,
      applicant,
      applicantId}) {
    return Booking(
        id: id ?? this.id,
        reason: reason ?? this.reason,
        start: start ?? this.start,
        end: end ?? this.end,
        note: note ?? this.note,
        room: room ?? this.room,
        key: key ?? this.key,
        decision: decision ?? this.decision,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        entity: entity ?? this.entity,
        applicant: applicant ?? this.applicant,
        applicantId: applicantId ?? this.applicantId);
  }

  static Booking empty() {
    return Booking(
        id: "",
        reason: "",
        start: DateTime.now(),
        end: DateTime.now(),
        note: "",
        room: Room.empty(),
        key: false,
        decision: Decision.pending,
        recurrenceRule: '',
        entity: '',
        applicant: Applicant.empty(),
        applicantId: '');
  }

  @override
  String toString() {
    return 'Booking{id: $id, reason: $reason, start: $start, end: $end, note: $note, room: $room, key: $key, decision: $decision, recurrenceRule: $recurrenceRule, entity: $entity, applicant: $applicant, applicantId: $applicantId}';
  }
}
