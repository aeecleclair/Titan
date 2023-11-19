import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/event/class/event.dart';
import 'package:myecl/event/providers/event_list_provider.dart';
import 'package:myecl/event/repositories/event_repository.dart';
import 'package:myecl/user/class/applicant.dart';

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
      Event newEvent = event.copyWith(
        id: "1",
      );
      expect(newEvent.id, "1");
      newEvent = event.copyWith(
        name: "Event 1",
      );
      expect(newEvent.name, "Event 1");
      newEvent = event.copyWith(
        organizer: "1",
      );
      expect(newEvent.organizer, "1");
      newEvent = event.copyWith(
        start: DateTime.parse("2021-01-01T00:00:00.000Z"),
      );
      expect(newEvent.start, DateTime.parse("2021-01-01T00:00:00.000Z"));
      newEvent = event.copyWith(
        end: DateTime.parse("2021-01-01T00:00:00.000Z"),
      );
      expect(newEvent.end, DateTime.parse("2021-01-01T00:00:00.000Z"));
      newEvent = event.copyWith(
        location: "Location 1",
      );
      expect(newEvent.location, "Location 1");
      newEvent = event.copyWith(
        type: CalendarEventType.eventAE,
      );
      expect(newEvent.type, CalendarEventType.eventAE);
      newEvent = event.copyWith(
        description: "Description 1",
      );
      expect(newEvent.description, "Description 1");
      newEvent = event.copyWith(
        allDay: false,
      );
      expect(newEvent.allDay, false);
      newEvent = event.copyWith(
        recurrenceRule: "",
      );
      expect(newEvent.recurrenceRule, "");
      newEvent = event.copyWith(
        applicantId: "1",
      );
      expect(newEvent.applicantId, "1");
      newEvent = event.copyWith(
        applicant: Applicant.empty().copyWith(id: "1"),
      );
      expect(newEvent.applicant, isA<Applicant>());
      expect(newEvent.applicant.id, "1");
      newEvent = event.copyWith(
        decision: Decision.approved,
      );
      expect(newEvent.decision, Decision.approved);
      newEvent = event.copyWith(
        roomId: "1",
      );
      expect(newEvent.roomId, "1");
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
        roomId: "1",
      );
      expect(event.toString(),
          'Event{id: 1, name: Event 1, organizer: 1, start: 2021-01-01 00:00:00.000Z, end: 2021-01-01 00:00:00.000Z, allDay: false, location: Location 1, type: CalendarEventType.eventAE, description: Description 1, recurrenceRule: , applicantId: 1, applicant: Applicant{name: Nom, firstname: Prénom, nickname: null, id: 1, email: empty@ecl.ec-lyon.fr, promo: null, phone: null}, decision: Decision.approved, roomId: 1}');
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
          "phone": null,
          "promo": null,
        },
        "decision": "accepted",
        "room_id": "1",
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
          "phone": null,
          "promo": null,
        },
        "decision": "approved",
        "room_id": "1",
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
        "room_id": "1",
      });
    });
  });

  group('Testing EventListNotifier : loadEventList', () {
    test('Should return a list of events', () async {
      final mockEventRepository = MockEventRepository();
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      final eventList = await eventListNotifier.loadEventList();
      expect(eventList, isA<AsyncData<List<Event>>>());
      expect(
          eventList
              .when(
                  data: (data) => data, error: (e, s) => [], loading: () => [])
              .length,
          2);
    });

    test('Should return an error', () async {
      final mockEventRepository = MockEventRepository();
      when(() => mockEventRepository.getAllEvent()).thenThrow(Exception());
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      final eventList = await eventListNotifier.loadEventList();
      expect(eventList, isA<AsyncError<List<Event>>>());
    });
  });

  group('Testing EventListNotifier : addEvent', () {
    test('Should return a list of events', () async {
      final mockEventRepository = MockEventRepository();
      final newEvent = Event.empty().copyWith(name: "Event 1");
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      when(() => mockEventRepository.createEvent(newEvent))
          .thenAnswer((_) async => newEvent);
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      await eventListNotifier.loadEventList();
      final eventList = await eventListNotifier.addEvent(newEvent);
      expect(eventList, true);
    });

    test('Should return an error if event not created', () async {
      final mockEventRepository = MockEventRepository();
      final newEvent = Event.empty().copyWith(name: "Event 1");
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      when(() => mockEventRepository.createEvent(newEvent))
          .thenThrow(Exception());
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      await eventListNotifier.loadEventList();
      final eventList = await eventListNotifier.addEvent(newEvent);
      expect(eventList, false);
    });

    test('Should return an error if event list not loaded', () async {
      final mockEventRepository = MockEventRepository();
      final newEvent = Event.empty().copyWith(name: "Event 1");
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      when(() => mockEventRepository.createEvent(newEvent))
          .thenAnswer((_) async => newEvent);
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      final eventList = await eventListNotifier.addEvent(newEvent);
      expect(eventList, false);
    });
  });

  group('Testing EventListNotifier : updateEvent', () {
    test('Should return a list of events', () async {
      final mockEventRepository = MockEventRepository();
      final newEvent = Event.empty().copyWith(name: "Event 1");
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      when(() => mockEventRepository.updateEvent(newEvent))
          .thenAnswer((_) async => true);
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      await eventListNotifier.loadEventList();
      final eventList = await eventListNotifier.updateEvent(newEvent);
      expect(eventList, true);
    });

    test('Should return an error if event not updated', () async {
      final mockEventRepository = MockEventRepository();
      final newEvent = Event.empty().copyWith(name: "Event 1");
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      when(() => mockEventRepository.updateEvent(newEvent))
          .thenThrow(Exception());
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      await eventListNotifier.loadEventList();
      final eventList = await eventListNotifier.updateEvent(newEvent);
      expect(eventList, false);
    });

    test('Should return an error if event list not loaded', () async {
      final mockEventRepository = MockEventRepository();
      final newEvent = Event.empty().copyWith(name: "Event 1");
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      when(() => mockEventRepository.updateEvent(newEvent))
          .thenAnswer((_) async => true);
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      final eventList = await eventListNotifier.updateEvent(newEvent);
      expect(eventList, false);
    });

    test('Should return an error if event not found', () async {
      final mockEventRepository = MockEventRepository();
      final newEvent = Event.empty().copyWith(name: "Event 1");
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      when(() => mockEventRepository.updateEvent(newEvent))
          .thenAnswer((_) async => false);
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      await eventListNotifier.loadEventList();
      final eventList = await eventListNotifier.updateEvent(newEvent);
      expect(eventList, false);
    });
  });

  group('Testing EventListNotifier : deleteEvent', () {
    test('Should return a list of events', () async {
      final mockEventRepository = MockEventRepository();
      final newEvent = Event.empty().copyWith(name: "Event 1");
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      when(() => mockEventRepository.deleteEvent(newEvent.id))
          .thenAnswer((_) async => true);
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      await eventListNotifier.loadEventList();
      final eventList = await eventListNotifier.deleteEvent(newEvent);
      expect(eventList, true);
    });

    test('Should return an error if event not deleted', () async {
      final mockEventRepository = MockEventRepository();
      final newEvent = Event.empty().copyWith(name: "Event 1");
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      when(() => mockEventRepository.deleteEvent(newEvent.id))
          .thenThrow(Exception());
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      await eventListNotifier.loadEventList();
      final eventList = await eventListNotifier.deleteEvent(newEvent);
      expect(eventList, false);
    });

    test('Should return an error if event list not loaded', () async {
      final mockEventRepository = MockEventRepository();
      final newEvent = Event.empty().copyWith(name: "Event 1");
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      when(() => mockEventRepository.deleteEvent(newEvent.id))
          .thenAnswer((_) async => true);
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      final eventList = await eventListNotifier.deleteEvent(newEvent);
      expect(eventList, false);
    });

    test('Should return an error if event not found', () async {
      final mockEventRepository = MockEventRepository();
      final newEvent = Event.empty().copyWith(name: "Event 1");
      when(() => mockEventRepository.getAllEvent()).thenAnswer((_) async => [
            Event.empty(),
            Event.empty(),
          ]);
      when(() => mockEventRepository.deleteEvent(newEvent.id))
          .thenAnswer((_) async => false);
      final eventListNotifier =
          EventListNotifier(eventRepository: mockEventRepository);
      await eventListNotifier.loadEventList();
      final eventList = await eventListNotifier.deleteEvent(newEvent);
      expect(eventList, false);
    });
  });
}
