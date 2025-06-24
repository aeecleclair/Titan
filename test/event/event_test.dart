import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/event/class/event.dart';
import 'package:titan/event/repositories/event_repository.dart';
import 'package:titan/event/tools/functions.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/user/class/applicant.dart';

class MockEventRepository extends Mock implements EventRepository {}

void main() {
  group('Testing Event class', () {
    test('Should return an event', () {
      final event = Event.empty();
      expect(event, isA<Event>());
    });

    test('Should return an event with the correct id', () {
      final event = Event.empty();
      expect(event.id, isA<String>());
    });

    test('Should update with new values', () {
      final event = Event.empty();
      Event newEvent = event.copyWith(id: "1");
      expect(newEvent.id, "1");
      newEvent = event.copyWith(name: "Event 1");
      expect(newEvent.name, "Event 1");
      newEvent = event.copyWith(organizer: "1");
      expect(newEvent.organizer, "1");
      newEvent = event.copyWith(
        start: DateTime.parse("2021-01-01T00:00:00.000Z"),
      );
      expect(newEvent.start, DateTime.parse("2021-01-01T00:00:00.000Z"));
      newEvent = event.copyWith(
        end: DateTime.parse("2021-01-01T00:00:00.000Z"),
      );
      expect(newEvent.end, DateTime.parse("2021-01-01T00:00:00.000Z"));
      newEvent = event.copyWith(location: "Location 1");
      expect(newEvent.location, "Location 1");
      newEvent = event.copyWith(type: CalendarEventType.eventAE);
      expect(newEvent.type, CalendarEventType.eventAE);
      newEvent = event.copyWith(description: "Description 1");
      expect(newEvent.description, "Description 1");
      newEvent = event.copyWith(allDay: false);
      expect(newEvent.allDay, false);
      newEvent = event.copyWith(recurrenceRule: "");
      expect(newEvent.recurrenceRule, "");
      newEvent = event.copyWith(applicantId: "1");
      expect(newEvent.applicantId, "1");
      newEvent = event.copyWith(applicant: Applicant.empty().copyWith(id: "1"));
      expect(newEvent.applicant, isA<Applicant>());
      expect(newEvent.applicant.id, "1");
      newEvent = event.copyWith(decision: Decision.approved);
    });

    test('Should print an event', () {
      final event = Event(
        id: "1",
        name: "Event 1",
        organizer: "1",
        start: DateTime.parse("2021-01-01T00:00:00.000Z"),
        end: DateTime.parse("2021-01-01T00:00:00.000Z"),
        location: "Location 1",
        type: CalendarEventType.eventAE,
        description: "Description 1",
        allDay: false,
        recurrenceRule: "",
        applicantId: "1",
        applicant: Applicant.empty().copyWith(id: "1"),
        decision: Decision.approved,
      );
      expect(
        event.toString(),
        'Event{id: 1, name: Event 1, organizer: 1, start: 2021-01-01 00:00:00.000Z, end: 2021-01-01 00:00:00.000Z, allDay: false, location: Location 1, type: CalendarEventType.eventAE, description: Description 1, recurrenceRule: , applicantId: 1, applicant: Applicant{name: Nom, firstname: Prénom, nickname: null, id: 1, email: empty@ecl.ec-lyon.fr, promo: null, phone: null, accountType: external}, decision: Decision.approved',
      );
    });

    test('Should parse an event from json', () {
      final event = Event.fromJson({
        "id": "1",
        "name": "Event 1",
        "organizer": "1",
        "start": "2021-01-01T00:00:00.000Z",
        "end": "2021-01-01T00:00:00.000Z",
        "location": "Location 1",
        "type": "eventAE",
        "description": "Description 1",
        "all_day": false,
        "recurrence_rule": "",
        "applicant_id": "1",
        "applicant": {
          "id": "1",
          "firstname": "First name 1",
          "name": "Last name 1",
          "nickname": null,
          "email": "email",
          "account_type": "external",
          "phone": null,
          "promo": null,
        },
        "decision": "accepted",
      });
      expect(event, isA<Event>());
    });

    test('Should return correct json', () {
      final event = Event.fromJson({
        "id": "1",
        "name": "Event 1",
        "organizer": "1",
        "start": "2021-01-01T00:00:00.000Z",
        "end": "2021-01-01T00:00:00.000Z",
        "location": "Location 1",
        "type": "Event AE",
        "description": "Description 1",
        "all_day": false,
        "recurrence_rule": "",
        "applicant_id": "1",
        "applicant": {
          "id": "1",
          "firstname": "First name 1",
          "name": "Last name 1",
          "nickname": null,
          "email": "email",
          "account_type": "external",
          "phone": null,
          "promo": null,
        },
        "decision": "approved",
      });
      expect(event.toJson(), {
        "id": "1",
        "name": "Event 1",
        "organizer": "1",
        "start": "2021-01-01T00:00:00.000Z",
        "end": "2021-01-01T00:00:00.000Z",
        "location": "Location 1",
        "type": "Event AE",
        "description": "Description 1",
        "all_day": false,
        "recurrence_rule": "",
        "applicant_id": "1",
        "decision": "approved",
      });
    });
  });

  group('Testing functions', () {
    test('Testing calendarEventTypeToString', () {
      expect(calendarEventTypeToString(CalendarEventType.eventAE), "Event AE");
      expect(
        calendarEventTypeToString(CalendarEventType.eventUSE),
        "Event USE",
      );
      expect(calendarEventTypeToString(CalendarEventType.happyHour), "HH");
      expect(calendarEventTypeToString(CalendarEventType.direction), "Strass");
      expect(calendarEventTypeToString(CalendarEventType.nightParty), "Rewass");
      expect(calendarEventTypeToString(CalendarEventType.other), "Autre");
    });

    test('Testing stringToCalendarEventType', () {
      expect(stringToCalendarEventType("Event AE"), CalendarEventType.eventAE);
      expect(
        stringToCalendarEventType("Event USE"),
        CalendarEventType.eventUSE,
      );
      expect(stringToCalendarEventType("HH"), CalendarEventType.happyHour);
      expect(stringToCalendarEventType("Strass"), CalendarEventType.direction);
      expect(stringToCalendarEventType("Rewass"), CalendarEventType.nightParty);
      expect(stringToCalendarEventType("Autre"), CalendarEventType.other);
      expect(stringToCalendarEventType(""), CalendarEventType.other);
    });

    test('Testing processDateOnlyHout', () {
      final date = DateTime.parse("2021-01-01T00:00:00.000Z");
      expect(processDateOnlyHour(date), "00:00");
      expect(processDateOnlyHour(date.add(const Duration(hours: 1))), "01:00");
    });

    test('Testing parseDate', () {
      final date = DateTime.parse("2021-01-01T00:00:00.000Z");
      final parts = parseDate(date);
      expect(parts.length, 2);
      expect(parts, ["01/01/2021", "00:00"]);
    });

    test('Testing parseDate', () {
      final date = DateTime.parse("2021-01-01T00:00:00.000Z");
      final parts = parseDate(date);
      expect(parts.length, 2);
      expect(parts, ["01/01/2021", "00:00"]);
    });

    test('Testing formatDates', () {
      final start = DateTime.parse("2021-01-01T00:00:00.000Z");
      final end = DateTime.parse("2021-01-01T01:00:00.000Z");
      final end2 = DateTime.parse("2021-01-02T00:00:00.000Z");
      const allDay = false;
      const allDay2 = true;
      final format = formatDates(start, end, allDay);
      final format2 = formatDates(start, end2, allDay);
      final format3 = formatDates(start, end, allDay2);
      final format4 = formatDates(start, end2, allDay2);
      expect(format, "Le 01/01/2021 de 00:00 à 01:00");
      expect(format2, "Du 01/01/2021 à 00:00 au 02/01/2021 à 00:00");
      expect(format3, "Le 01/01/2021 toute la journée");
      expect(format4, "Du 01/01/2021 à 00:00 au 02/01/2021 à 00:00");
    });

    test('Testing getMonth', () {
      expect(getMonth(0), "Décembre");
      expect(getMonth(1), "Janvier");
      expect(getMonth(2), "Février");
      expect(getMonth(3), "Mars");
      expect(getMonth(4), "Avril");
      expect(getMonth(5), "Mai");
      expect(getMonth(6), "Juin");
      expect(getMonth(7), "Juillet");
      expect(getMonth(8), "Août");
      expect(getMonth(9), "Septembre");
      expect(getMonth(10), "Octobre");
      expect(getMonth(11), "Novembre");
      expect(getMonth(12), "Décembre");
    });

    test('Testing formatRecurrenceRule', () {
      final start = DateTime.parse("2021-01-01T00:00:00.000Z");
      final end = DateTime.parse("2021-01-01T01:00:00.000Z");
      final end2 = DateTime.parse("2021-01-02T00:00:00.000Z");
      const recurrenceRule =
          "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR,SA,SU;WKST=MO;INTERVAL=1;UNTIL=20211231T235959Z";
      const recurrenceRule2 = "";
      const recurrenceRule3 =
          "FREQ=WEEKLY;BYMONTH=1;BYDAY=MO;WKST=MO;UNTIL=20211231T235959Z";
      const allDay = false;
      const allDay2 = true;
      expect(
        formatRecurrenceRule(start, end, recurrenceRule, allDay),
        "Tous les Lundi, Mardi, Mercredi, Jeudi, Vendredi, Samedi et Dimanche de 00:00 à 01:00 jusqu'au 31/12/2021",
      );
      expect(
        formatRecurrenceRule(start, end2, recurrenceRule, allDay),
        "Tous les Lundi, Mardi, Mercredi, Jeudi, Vendredi, Samedi et Dimanche de 00:00 à 00:00 jusqu'au 31/12/2021",
      );
      expect(
        formatRecurrenceRule(start, end, recurrenceRule2, allDay),
        "Le 01/01/2021 de 00:00 à 01:00",
      );
      expect(
        formatRecurrenceRule(start, end2, recurrenceRule2, allDay),
        "Du 01/01/2021 à 00:00 au 02/01/2021 à 00:00",
      );
      expect(
        formatRecurrenceRule(start, end, recurrenceRule, allDay2),
        "Tous les Lundi, Mardi, Mercredi, Jeudi, Vendredi, Samedi et Dimanche toute la journée jusqu'au 31/12/2021",
      );
      expect(
        formatRecurrenceRule(start, end2, recurrenceRule, allDay2),
        "Tous les Lundi, Mardi, Mercredi, Jeudi, Vendredi, Samedi et Dimanche toute la journée jusqu'au 31/12/2021",
      );
      expect(
        formatRecurrenceRule(start, end, recurrenceRule2, allDay2),
        "Le 01/01/2021 toute la journée",
      );
      expect(
        formatRecurrenceRule(start, end2, recurrenceRule2, allDay2),
        "Du 01/01/2021 à 00:00 au 02/01/2021 à 00:00",
      );
      expect(
        formatRecurrenceRule(start, end, recurrenceRule3, allDay),
        "Tous les Lundi de 00:00 à 01:00 jusqu'au 31/12/2021",
      );
      expect(
        formatRecurrenceRule(start, end2, recurrenceRule3, allDay),
        "Tous les Lundi de 00:00 à 00:00 jusqu'au 31/12/2021",
      );
      expect(
        formatRecurrenceRule(start, end, recurrenceRule3, allDay2),
        "Tous les Lundi toute la journée jusqu'au 31/12/2021",
      );
      expect(
        formatRecurrenceRule(start, end2, recurrenceRule3, allDay2),
        "Tous les Lundi toute la journée jusqu'au 31/12/2021",
      );
    });

    test('Testing mergeDates', () {
      final date = DateTime.parse("2021-01-01T00:00:00.000Z");
      final date2 = DateTime.parse("2021-02-03T01:00:00.000Z");
      expect(
        mergeDates(date, date2),
        DateTime.parse("2021-01-01T01:00:00.000"),
      );
    });

    test('Testing dayDifference', () {
      final date = DateTime.parse("2021-01-01T00:00:00.000Z");
      final date2 = DateTime.parse("2021-01-02T00:00:00.000Z");
      final date3 = DateTime.parse("2021-01-03T00:00:00.000Z");
      expect(dayDifference(date, date2), 1);
      expect(dayDifference(date, date3), 2);
    });

    test('Testing formatDelayToToday', () {
      final now = DateTime.parse("2021-01-04T00:00:00.000Z");
      final tomorrow = DateTime.parse("2021-01-05T00:00:00.000Z");
      final in3Days = DateTime.parse("2021-01-07T00:00:00.000Z");
      final in3Weeks = DateTime.parse("2021-01-25T00:00:00.000Z");
      final in3Months = DateTime.parse("2021-04-04T00:00:00.000Z");
      final in3Years = DateTime.parse("2024-01-04T00:00:00.000Z");
      expect(formatDelayToToday(now, now), "Aujourd'hui");
      expect(formatDelayToToday(tomorrow, now), "Demain");
      expect(formatDelayToToday(in3Days, now), "Dans 3 jours");
      expect(formatDelayToToday(in3Weeks, now), "Dans 21 jours");
      expect(formatDelayToToday(in3Months, now), "Dans 3 mois");
      expect(formatDelayToToday(in3Years, now), "Dans 3 ans");
    });
  });
}
