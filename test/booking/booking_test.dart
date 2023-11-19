
import 'package:flutter_test/flutter_test.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/user/class/applicant.dart';
import 'package:myecl/user/class/list_users.dart';

void main() {
  group('Testing Room class', () {
    test('Should return a room', () {
      final room = Room.empty();
      expect(room, isA<Room>());
    });

    test('Should return a room with a valid id', () {
      final room = Room.empty();
      expect(room.id, isA<String>());
    });

    test('Should update with new values', () {
      final room = Room.empty();
      Room newRoom = room.copyWith(id: "1");
      expect(newRoom.id, "1");
      newRoom = room.copyWith(name: "name");
      expect(newRoom.name, "name");
    });

    test('Should print a room', () {
      final room = Room(
        id: "1",
        name: "name",
      );
      expect(room.toString(), 'Room{name: name, id: 1}');
    });

    test('Should parse a room from json', () {
      final room = Room.fromJson({
        "name": "name",
        "id": "1",
      });
      expect(room, isA<Room>());
    });

    test('Should return correct json', () {
      final room = Room.fromJson({
        "name": "name",
        "id": "1",
      });
      expect(room.toJson(), {
        "name": "name",
        "id": "1",
      });
    });
  });

  group('Testing Booking class', () {
    test('Should return a booking', () {
      final booking = Booking.empty();
      expect(booking, isA<Booking>());
    });

    test('Should return a booking with a valid id', () {
      final booking = Booking.empty();
      expect(booking.id, isA<String>());
    });

    test('Should update with new values', () {
      final booking = Booking.empty();
      final newRoom = Room.empty().copyWith(id: "1");
      final newUser = Applicant.empty().copyWith(id: "1");
      Booking newBooking = booking.copyWith(
        id: "1",
      );
      expect(newBooking.id, "1");
      newBooking = booking.copyWith(
        reason: "reason",
      );
      expect(newBooking.reason, "reason");
      newBooking = booking.copyWith(
        start: DateTime.parse("2021-01-01T00:00:00.000Z"),
      );
      expect(newBooking.start, DateTime.parse("2021-01-01T00:00:00.000Z"));
      newBooking = booking.copyWith(
        end: DateTime.parse("2021-01-01T00:00:00.000Z"),
      );
      expect(newBooking.end, DateTime.parse("2021-01-01T00:00:00.000Z"));
      newBooking = booking.copyWith(
        note: "note",
      );
      expect(newBooking.note, "note");
      newBooking = booking.copyWith(
        room: newRoom,
      );
      expect(newBooking.room, isA<Room>());
      expect(newBooking.room.id, "1");
      newBooking = booking.copyWith(
        key: true,
      );
      expect(newBooking.key, true);
      newBooking = booking.copyWith(
        decision: Decision.approved,
      );
      expect(newBooking.decision, Decision.approved);
      newBooking = booking.copyWith(
        recurrenceRule: "",
      );
      expect(newBooking.recurrenceRule, "");
      newBooking = booking.copyWith(
        entity: "entity",
      );
      expect(newBooking.entity, "entity");
      newBooking = booking.copyWith(
        applicant: newUser,
      );
      expect(newBooking.applicant, isA<SimpleUser>());
      expect(newBooking.applicant.id, "1");
      newBooking = booking.copyWith(
        applicantId: "1",
      );
      expect(newBooking.applicantId, "1");
    });

    test('Should print a booking', () {
      final booking = Booking(
        id: "1",
        reason: "reason",
        start: DateTime.parse("2021-01-01T00:00:00.000Z"),
        end: DateTime.parse("2021-01-01T00:00:00.000Z"),
        note: "note",
        room: Room.empty().copyWith(id: "1"),
        key: true,
        decision: Decision.approved,
        recurrenceRule: "",
        entity: "entity",
        applicant: Applicant.empty().copyWith(id: "1"),
        applicantId: "1",
      );
      expect(booking.toString(),
          "Booking{id: 1, reason: reason, start: 2021-01-01 00:00:00.000Z, end: 2021-01-01 00:00:00.000Z, note: note, room: Room{name: , id: 1}, key: true, decision: Decision.approved, recurrenceRule: , entity: entity, applicant: Applicant{name: Nom, firstname: Prénom, nickname: null, id: 1, email: empty@ecl.ec-lyon.fr, promo: null, phone: null}, applicantId: 1}");
    });

    test('Should parse a booking from json', () {
      final booking = Booking.fromJson({
        "id": "1",
        "reason": "reason",
        "start": "2021-01-01T00:00:00.000Z",
        "end": "2021-01-01T00:00:00.000Z",
        "note": "note",
        "room": {
          "id": "1",
          "name": "name",
        },
        "key": true,
        "decision": "approved",
        "recurrence_rule": "",
        "entity": "entity",
        "applicant_id": "1",
        "applicant": {
          "id": "1",
          "firstname": "first_name",
          "name": "last_name",
          "nickname": "nickname",
          "email": "email",
          "phone": "phone",
          "promo": null,
        }
      });
      expect(booking, isA<Booking>());
      expect(booking.applicant, isA<SimpleUser>());
      expect(booking.room, isA<Room>());
      expect(booking.id, "1");
      expect(booking.reason, "reason");
      expect(booking.start, DateTime.parse("2021-01-01T00:00:00.000Z"));
      expect(booking.end, DateTime.parse("2021-01-01T00:00:00.000Z"));
      expect(booking.note, "note");
      expect(booking.key, true);
      expect(booking.decision, Decision.approved);
      expect(booking.recurrenceRule, "");
      expect(booking.entity, "entity");
      expect(booking.applicantId, "1");
    });

    test('Should parse a booking from json with applicant_id', () {
      final booking = Booking.fromJson({
        "id": "1",
        "reason": "reason",
        "start": "2021-01-01T00:00:00.000Z",
        "end": "2021-01-01T00:00:00.000Z",
        "note": "note",
        "room": {
          "id": "1",
          "name": "name",
        },
        "key": true,
        "decision": "approved",
        "recurrence_rule": "",
        "entity": "entity",
        "applicant_id": "1"
      });
      expect(booking, isA<Booking>());
      expect(booking.applicant, isA<SimpleUser>());
      expect(booking.room, isA<Room>());
      expect(booking.id, "1");
      expect(booking.reason, "reason");
      expect(booking.start, DateTime.parse("2021-01-01T00:00:00.000Z"));
      expect(booking.end, DateTime.parse("2021-01-01T00:00:00.000Z"));
      expect(booking.note, "note");
      expect(booking.key, true);
      expect(booking.decision, Decision.approved);
      expect(booking.recurrenceRule, "");
      expect(booking.entity, "entity");
      expect(booking.applicantId, "1");
    });

    test('Should return a correct json', () {
      final booking = Booking.fromJson({
        "id": "1",
        "reason": "reason",
        "start": "2021-01-01T00:00:00.000Z",
        "end": "2021-01-01T00:00:00.000Z",
        "note": "note",
        "room": {
          "id": "1",
          "name": "name",
        },
        "key": true,
        "decision": "approved",
        "recurrence_rule": "",
        "entity": "entity",
        "applicant_id": "1",
        "applicant": {
          "id": "1",
          "firstname": "first_name",
          "name": "last_name",
          "nickname": "nickname",
          "email": "email",
          "phone": "phone",
          "promo": null,
        }
      });
      expect(booking.toJson(), {
        "id": "1",
        "reason": "reason",
        "start": "2021-01-01T00:00:00.000Z",
        "end": "2021-01-01T00:00:00.000Z",
        "note": "note",
        "room_id": "1",
        "key": true,
        "decision": "approved",
        "recurrence_rule": "",
        "entity": "entity",
        "applicant_id": "1",
      });
    });
  });
}
