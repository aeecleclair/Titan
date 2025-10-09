import 'package:titan/service/class/room.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/user/class/applicant.dart';

class Booking {
  final String id;
  final String reason;
  final DateTime start;
  final DateTime end;
  final DateTime creation;
  final String? note;
  final Room room;
  final bool key;
  final Decision decision;
  final String recurrenceRule;
  final String entity;
  final Applicant applicant;
  final String applicantId;

  Booking({
    required this.id,
    required this.reason,
    required this.start,
    required this.end,
    required this.creation,
    this.note,
    required this.room,
    required this.key,
    required this.decision,
    required this.recurrenceRule,
    required this.entity,
    required this.applicant,
    required this.applicantId,
  });

  static Booking fromJson(Map<String, dynamic> json) {
    Booking booking = Booking(
      id: json["id"],
      reason: json["reason"],
      start: processDateFromAPI(json["start"]),
      end: processDateFromAPI(json["end"]),
      creation: processDateFromAPI(json["creation"]),
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
    return booking;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["reason"] = reason;
    data["start"] = processDateToAPI(start);
    data["end"] = processDateToAPI(end);
    data["creation"] = processDateToAPI(creation);
    data["note"] = note;
    data["room_id"] = room.id;
    data["key"] = key;
    data["decision"] = decision.name;
    data["recurrence_rule"] = recurrenceRule;
    data["entity"] = entity;
    data["applicant_id"] = applicantId;
    return data;
  }

  Booking copyWith({
    String? id,
    String? reason,
    DateTime? start,
    DateTime? end,
    DateTime? creation,
    String? note,
    Room? room,
    bool? key,
    Decision? decision,
    String? recurrenceRule,
    String? entity,
    Applicant? applicant,
    String? applicantId,
  }) {
    return Booking(
      id: id ?? this.id,
      reason: reason ?? this.reason,
      start: start ?? this.start,
      end: end ?? this.end,
      creation: creation ?? this.creation,
      note: note ?? this.note,
      room: room ?? this.room,
      key: key ?? this.key,
      decision: decision ?? this.decision,
      recurrenceRule: recurrenceRule ?? this.recurrenceRule,
      entity: entity ?? this.entity,
      applicant: applicant ?? this.applicant,
      applicantId: applicantId ?? this.applicantId,
    );
  }

  static Booking empty() {
    return Booking(
      id: "",
      reason: "",
      start: DateTime.now(),
      end: DateTime.now(),
      creation: DateTime.now(),
      note: "",
      room: Room.empty(),
      key: false,
      decision: Decision.pending,
      recurrenceRule: '',
      entity: '',
      applicant: Applicant.empty(),
      applicantId: '',
    );
  }

  @override
  String toString() {
    return 'Booking{id: $id, reason: $reason, start: $start, end: $end, creation: $creation, note: $note, room: $room, key: $key, decision: $decision, recurrenceRule: $recurrenceRule, entity: $entity, applicant: $applicant, applicantId: $applicantId}';
  }
}
