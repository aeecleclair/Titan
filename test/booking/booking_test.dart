import 'package:flutter_test/flutter_test.dart';
import 'package:titan/booking/class/booking.dart';
import 'package:titan/service/class/room.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/user/class/applicant.dart';
import 'package:titan/user/class/simple_users.dart';

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
      newRoom = room.copyWith(managerId: "1");
      expect(newRoom.managerId, "1");
    });

    test('Should print a room', () {
      final room = Room(id: "1", managerId: "1", name: "name");
      expect(room.toString(), 'Room{name: name, manager_id: 1, id: 1}');
    });

    test('Should parse a room from json', () {
      final room = Room.fromJson({
        "name": "name",
        "id": "1",
        "manager_id": "1",
      });
      expect(room, isA<Room>());
    });

    test('Should return correct json', () {
      final room = Room.fromJson({
        "name": "name",
        "id": "1",
        "manager_id": "1",
      });
      expect(room.toJson(), {"name": "name", "id": "1", "manager_id": "1"});
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
      Booking newBooking = booking.copyWith(id: "1");
      expect(newBooking.id, "1");
      newBooking = booking.copyWith(reason: "reason");
      expect(newBooking.reason, "reason");
      newBooking = booking.copyWith(
        start: DateTime.parse("2021-01-01T00:00:00.000Z"),
      );
      expect(newBooking.start, DateTime.parse("2021-01-01T00:00:00.000Z"));
      newBooking = booking.copyWith(
        end: DateTime.parse("2021-01-01T00:00:00.000Z"),
      );
      expect(newBooking.end, DateTime.parse("2021-01-01T00:00:00.000Z"));
      newBooking = booking.copyWith(note: "note");
      expect(newBooking.note, "note");
      newBooking = booking.copyWith(room: newRoom);
      expect(newBooking.room, isA<Room>());
      expect(newBooking.room.id, "1");
      newBooking = booking.copyWith(key: true);
      expect(newBooking.key, true);
      newBooking = booking.copyWith(decision: Decision.approved);
      expect(newBooking.decision, Decision.approved);
      newBooking = booking.copyWith(recurrenceRule: "");
      expect(newBooking.recurrenceRule, "");
      newBooking = booking.copyWith(entity: "entity");
      expect(newBooking.entity, "entity");
      newBooking = booking.copyWith(applicant: newUser);
      expect(newBooking.applicant, isA<SimpleUser>());
      expect(newBooking.applicant.id, "1");
      newBooking = booking.copyWith(applicantId: "1");
      expect(newBooking.applicantId, "1");
    });

    test('Should print a booking', () {
      final booking = Booking(
        id: "1",
        reason: "reason",
        start: DateTime.parse("2021-01-01T00:00:00.000Z"),
        end: DateTime.parse("2021-01-01T00:00:00.000Z"),
        creation: DateTime.parse("2021-01-01T00:00:00.000Z"),
        note: "note",
        room: Room.empty().copyWith(id: "1"),
        key: true,
        decision: Decision.approved,
        recurrenceRule: "",
        entity: "entity",
        applicant: Applicant.empty().copyWith(id: "1"),
        applicantId: "1",
      );
      expect(
        booking.toString(),
        "Booking{id: 1, reason: reason, start: 2021-01-01 00:00:00.000Z, end: 2021-01-01 00:00:00.000Z, creation: 2021-01-01 00:00:00.000Z, note: note, room: Room{name: , manager_id: , id: 1}, key: true, decision: Decision.approved, recurrenceRule: , entity: entity, applicant: Applicant{name: Nom, firstname: Prénom, nickname: null, id: 1, email: empty@ecl.ec-lyon.fr, promo: null, phone: null, accountType: external}, applicantId: 1}",
      );
    });

    test('Should parse a booking from json', () {
      final datetime = DateTime.utc(2021, 1, 1);
      final booking = Booking.fromJson({
        "id": "1",
        "reason": "reason",
        "start": datetime.toIso8601String(),
        "end": datetime.toIso8601String(),
        "creation": datetime.toIso8601String(),
        "note": "note",
        "room": {"id": "1", "name": "name", "manager_id": "1"},
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
          "account_type": "external",
        },
      });
      expect(booking, isA<Booking>());
      expect(booking.applicant, isA<SimpleUser>());
      expect(booking.room, isA<Room>());
      expect(booking.id, "1");
      expect(booking.reason, "reason");
      expect(booking.start, datetime.toLocal());
      expect(booking.end, datetime.toLocal());
      expect(booking.note, "note");
      expect(booking.key, true);
      expect(booking.decision, Decision.approved);
      expect(booking.recurrenceRule, "");
      expect(booking.entity, "entity");
      expect(booking.applicantId, "1");
    });

    test('Should parse a booking from json with applicant_id', () {
      final datetime = DateTime.utc(2021, 1, 1);
      final booking = Booking.fromJson({
        "id": "1",
        "reason": "reason",
        "start": datetime.toIso8601String(),
        "end": datetime.toIso8601String(),
        "creation": datetime.toIso8601String(),
        "note": "note",
        "room": {"id": "1", "name": "name", "manager_id": "1"},
        "key": true,
        "decision": "approved",
        "recurrence_rule": "",
        "entity": "entity",
        "applicant_id": "1",
      });
      expect(booking, isA<Booking>());
      expect(booking.applicant, isA<SimpleUser>());
      expect(booking.room, isA<Room>());
      expect(booking.id, "1");
      expect(booking.reason, "reason");
      expect(booking.start, datetime.toLocal());
      expect(booking.end, datetime.toLocal());
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
        "creation": "2021-01-01T00:00:00.000Z",
        "note": "note",
        "room": {"id": "1", "name": "name", "manager_id": "1"},
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
          "account_type": "external",
        },
      });
      expect(booking.toJson(), {
        "id": "1",
        "reason": "reason",
        "start": "2021-01-01T00:00:00.000Z",
        "end": "2021-01-01T00:00:00.000Z",
        "creation": "2021-01-01T00:00:00.000Z",
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

  group('Testing functions', () {
    test('String to decision', () {
      expect(Decision.approved, stringToDecision("approved"));
      expect(Decision.declined, stringToDecision("declined"));
      expect(Decision.pending, stringToDecision("pending"));
      expect(Decision.pending, stringToDecision("random"));
    });

    test('formatDates returns correct string for same day event', () {
      final dateStart = DateTime(2022, 1, 1, 10, 0);
      final dateEnd = DateTime(2022, 1, 1, 14, 0);
      const allDay = false;
      final result = formatDates(dateStart, dateEnd, allDay);
      expect(result, "Le 01/01/2022 de 10:00 à 14:00");
    });

    test('formatDates returns correct string for same day all day event', () {
      final dateStart = DateTime(2022, 1, 1);
      final dateEnd = DateTime(2022, 1, 1);
      const allDay = true;
      final result = formatDates(dateStart, dateEnd, allDay);
      expect(result, "Le 01/01/2022 toute la journée");
    });

    test('formatDates returns correct string for multi-day event', () {
      final dateStart = DateTime(2022, 1, 1, 10, 0);
      final dateEnd = DateTime(2022, 1, 3, 14, 0);
      const allDay = false;
      final result = formatDates(dateStart, dateEnd, allDay);
      expect(result, "Du 01/01/2022 à 10:00 au 03/01/2022 à 14:00");
    });

    // test(
    //   'formatRecurrenceRule returns correct string for empty recurrenceRule',
    //   () {
    //     DateTime dateStart = DateTime(2022, 1, 1, 10, 0);
    //     DateTime dateEnd = DateTime(2022, 1, 1, 12, 0);
    //     String recurrenceRule = "";
    //     bool allDay = false;
    //     expect(
    //       formatRecurrenceRule(dateStart, dateEnd, recurrenceRule, allDay),
    //       "Le 01/01/2022 de 10:00 à 12:00",
    //     );
    //   },
    // );

    // test(
    //   'formatRecurrenceRule returns correct string for non-empty recurrenceRule',
    //   () {
    //     DateTime dateStart = DateTime(2022, 1, 1, 10, 0);
    //     DateTime dateEnd = DateTime(2022, 1, 1, 12, 0);
    //     String recurrenceRule =
    //         "FREQ=WEEKLY;BYDAY=MO,WE,FR;UNTIL=20220131T000000Z";
    //     bool allDay = false;
    //     expect(
    //       formatRecurrenceRule(dateStart, dateEnd, recurrenceRule, allDay),
    //       "Tous les Lundi, Mercredi et Vendredi de 10:00 à 12:00 jusqu'au 31/01/2022",
    //     );
    //   },
    // );

    // test('formatRecurrenceRule returns correct string for allDay event', () {
    //   DateTime dateStart = DateTime(2022, 1, 1);
    //   DateTime dateEnd = DateTime(2022, 1, 3);
    //   String recurrenceRule = "";
    //   bool allDay = true;
    //   expect(
    //     formatRecurrenceRule(dateStart, dateEnd, recurrenceRule, allDay),
    //     "Du 01/01/2022 à 00:00 au 03/01/2022 à 00:00",
    //   );
    // });

    test('combineDate returns correct date', () {
      final date = DateTime(2022, 1, 1);
      final time = DateTime(2000, 2, 2, 10, 0);
      expect(combineDate(date, time), equals(DateTime(2022, 1, 1, 10, 0)));
    });
  });
}
