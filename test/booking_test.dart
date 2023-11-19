import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/booking/class/booking.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/booking_list_provider.dart';
import 'package:myecl/booking/providers/confirmed_booking_list_provider.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/booking/repositories/booking_repository.dart';
import 'package:myecl/booking/repositories/rooms_repository.dart';
import 'package:myecl/booking/repositories/user_booking_repository.dart';

class MockBookingRepository extends Mock implements BookingRepository {}

class MockRoomRepository extends Mock implements RoomRepository {}

class MockUserBookingRepository extends Mock implements UserBookingRepository {}

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

  group('Testing BookingListProvider : loadBookings', () {
    test('Should load bookings', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [
                Booking.empty(),
                Booking.empty(),
              ]);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      final bookings = await bookingListProvider.loadBookings();
      expect(bookings, isA<AsyncData<List<Booking>>>());
      expect(
          bookings
              .when(
                data: (data) => data,
                loading: () => [],
                error: (error, stack) => [],
              )
              .length,
          2);
    });

    test('Should load bookings with error', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      when(() => mockBookingRepository.getBookingList()).thenThrow(Exception());
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      final bookings = await bookingListProvider.loadBookings();
      expect(bookings, isA<AsyncError<List<Booking>>>());
    });
  });

  group('Testing BookingListProvider : loadUserBookings', () {
    test('Should load user bookings', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      when(() => mockUserBookingRepository.getMyBookingList("1"))
          .thenAnswer((_) async => [
                Booking.empty(),
                Booking.empty(),
              ]);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      final bookings = await bookingListProvider.loadUserBookings("1");
      expect(bookings, isA<AsyncData<List<Booking>>>());
      expect(
          bookings
              .when(
                data: (data) => data,
                loading: () => [],
                error: (error, stack) => [],
              )
              .length,
          2);
    });

    test('Should load user bookings with error', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      when(() => mockUserBookingRepository.getMyBookingList("1"))
          .thenThrow(Exception());
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      final bookings = await bookingListProvider.loadUserBookings("1");
      expect(bookings, isA<AsyncError<List<Booking>>>());
    });
  });

  group('Testing BookingListProvider : addBooking', () {
    test('Should add a booking', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [
                Booking.empty(),
                Booking.empty(),
              ]);
      when(() => mockBookingRepository.createBooking(newBooking))
          .thenAnswer((_) async => newBooking);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final booking = await bookingListProvider.addBooking(newBooking);
      expect(booking, true);
    });

    test('Should return an error if booking is not added', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [
                Booking.empty(),
                Booking.empty(),
              ]);
      when(() => mockBookingRepository.createBooking(newBooking))
          .thenThrow(Exception());
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final booking = await bookingListProvider.addBooking(newBooking);
      expect(booking, false);
    });

    test('Should return an error if booking list is not loaded', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.createBooking(newBooking))
          .thenAnswer((_) async => Booking.empty());
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      final booking = await bookingListProvider.addBooking(newBooking);
      expect(booking, false);
    });
  });

  group('Testing BookingListProvider : updateBooking', () {
    test('Should update a booking', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [Booking.empty(), newBooking]);
      when(() => mockBookingRepository.updateBooking(newBooking))
          .thenAnswer((_) async => true);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final booking = await bookingListProvider.updateBooking(newBooking);
      expect(booking, true);
    });

    test('Should return an error if booking is not updated', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [Booking.empty(), newBooking]);
      when(() => mockBookingRepository.updateBooking(newBooking))
          .thenThrow(Exception());
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final booking = await bookingListProvider.updateBooking(newBooking);
      expect(booking, false);
    });

    test('Should return an error if booking list is not loaded', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.updateBooking(newBooking))
          .thenAnswer((_) async => true);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      final booking = await bookingListProvider.updateBooking(newBooking);
      expect(booking, false);
    });

    test('Should return an error if booking is not found', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [
                Booking.empty(),
                Booking.empty(),
              ]);
      when(() => mockBookingRepository.updateBooking(newBooking))
          .thenAnswer((_) async => false);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final booking = await bookingListProvider.updateBooking(newBooking);
      expect(booking, false);
    });
  });

  group('Testing BookingListProvider : deleteBooking', () {
    test('Should delete a booking', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [Booking.empty(), newBooking]);
      when(() => mockBookingRepository.deleteBooking(newBooking.id))
          .thenAnswer((_) async => true);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final booking = await bookingListProvider.deleteBooking(newBooking);
      expect(booking, true);
    });

    test('Should return an error if booking is not deleted', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [Booking.empty(), newBooking]);
      when(() => mockBookingRepository.deleteBooking(newBooking.id))
          .thenThrow(Exception());
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final booking = await bookingListProvider.deleteBooking(newBooking);
      expect(booking, false);
    });

    test('Should return an error if booking list is not loaded', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.deleteBooking(newBooking.id))
          .thenAnswer((_) async => true);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      final booking = await bookingListProvider.deleteBooking(newBooking);
      expect(booking, false);
    });

    test('Should return an error if booking is not found', () async {
      final mockBookingRepository = MockBookingRepository();
      final mockUserBookingRepository = MockUserBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getBookingList())
          .thenAnswer((_) async => [
                Booking.empty(),
                Booking.empty(),
              ]);
      when(() => mockBookingRepository.deleteBooking(newBooking.id))
          .thenAnswer((_) async => false);
      final bookingListProvider = BookingListProvider(
        bookingRepository: mockBookingRepository,
        userRepository: mockUserBookingRepository,
      );
      await bookingListProvider.loadBookings();
      final booking = await bookingListProvider.deleteBooking(newBooking);
      expect(booking, false);
    });
  });

  group('Testing ConfirmedBookingListProvider : loadConfirmedBooking', () {
    test('Should load confirmed booking', () async {
      final mockBookingRepository = MockBookingRepository();
      final newBooking = Booking.empty().copyWith(id: "1");
      when(() => mockBookingRepository.getConfirmedBookingList())
          .thenAnswer((_) async => [newBooking]);
      final bookingListProvider = ConfirmedBookingListProvider(
        bookingRepository: mockBookingRepository,
      );
      final confirmedBookings =
          await bookingListProvider.loadConfirmedBooking();
      expect(confirmedBookings, isA<AsyncData<List<Booking>>>());
      expect(
          confirmedBookings
              .when(
                data: (data) => data,
                loading: () => [],
                error: (_, __) => [],
              )
              .length,
          1);
    });

    test('Should return an error if confirmed booking is not loaded', () async {
      final mockBookingRepository = MockBookingRepository();
      when(() => mockBookingRepository.getConfirmedBookingList())
          .thenThrow(Exception());
      final bookingListProvider = ConfirmedBookingListProvider(
        bookingRepository: mockBookingRepository,
      );
      final confirmedBookingList =
          await bookingListProvider.loadConfirmedBooking();
      expect(confirmedBookingList, isA<AsyncError<List<Booking>>>());
    });
  });

  group('Testing RoomListNotifier : loadRooms', () {
    test('Should load rooms', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.getRoomList())
          .thenAnswer((_) async => [newRoom]);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      final rooms = await roomListProvider.loadRooms();
      expect(rooms, isA<AsyncData<List<Room>>>());
      expect(
          rooms
              .when(
                data: (data) => data,
                loading: () => [],
                error: (_, __) => [],
              )
              .length,
          1);
    });

    test('Should return an error if rooms are not loaded', () async {
      final mockRoomRepository = MockRoomRepository();
      when(() => mockRoomRepository.getRoomList()).thenThrow(Exception());
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      final rooms = await roomListProvider.loadRooms();
      expect(rooms, isA<AsyncError<List<Room>>>());
    });
  });

  group('Testing RoomListNotifier : addRoom', () {
    test('Should add a room', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.getRoomList())
          .thenAnswer((_) async => [Room.empty()]);
      when(() => mockRoomRepository.createRoom(newRoom))
          .thenAnswer((_) async => newRoom);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      await roomListProvider.loadRooms();
      final room = await roomListProvider.addRoom(newRoom);
      expect(room, true);
    });

    test('Should return an error if room is not added', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.getRoomList())
          .thenAnswer((_) async => [Room.empty()]);
      when(() => mockRoomRepository.createRoom(newRoom)).thenThrow(Exception());
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      await roomListProvider.loadRooms();
      final room = await roomListProvider.addRoom(newRoom);
      expect(room, false);
    });

    test('Should return an error if room list is not loaded', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.createRoom(newRoom))
          .thenAnswer((_) async => newRoom);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      final room = await roomListProvider.addRoom(newRoom);
      expect(room, false);
    });
  });

  group('Testing RoomListNotifier : updateRoom', () {
    test('Should update a room', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.getRoomList())
          .thenAnswer((_) async => [Room.empty(), newRoom]);
      when(() => mockRoomRepository.updateRoom(newRoom))
          .thenAnswer((_) async => true);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      await roomListProvider.loadRooms();
      final room = await roomListProvider.updateRoom(newRoom);
      expect(room, true);
    });

    test('Should return an error if room is not updated', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.getRoomList())
          .thenAnswer((_) async => [Room.empty(), newRoom]);
      when(() => mockRoomRepository.updateRoom(newRoom)).thenThrow(Exception());
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      await roomListProvider.loadRooms();
      final room = await roomListProvider.updateRoom(newRoom);
      expect(room, false);
    });

    test('Should return an error if room list is not loaded', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.updateRoom(newRoom))
          .thenAnswer((_) async => true);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      final room = await roomListProvider.updateRoom(newRoom);
      expect(room, false);
    });

    test('Should return an error if room is not found', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.getRoomList()).thenAnswer((_) async => [
            Room.empty(),
            Room.empty(),
          ]);
      when(() => mockRoomRepository.updateRoom(newRoom))
          .thenAnswer((_) async => false);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      await roomListProvider.loadRooms();
      final room = await roomListProvider.updateRoom(newRoom);
      expect(room, false);
    });
  });

  group('Testing RoomListNotifier : deleteRoom', () {
    test('Should delete a room', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.getRoomList())
          .thenAnswer((_) async => [Room.empty(), newRoom]);
      when(() => mockRoomRepository.deleteRoom(newRoom.id))
          .thenAnswer((_) async => true);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      await roomListProvider.loadRooms();
      final room = await roomListProvider.deleteRoom(newRoom);
      expect(room, true);
    });

    test('Should return an error if room is not deleted', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.getRoomList())
          .thenAnswer((_) async => [Room.empty(), newRoom]);
      when(() => mockRoomRepository.deleteRoom(newRoom.id))
          .thenThrow(Exception());
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      await roomListProvider.loadRooms();
      final room = await roomListProvider.deleteRoom(newRoom);
      expect(room, false);
    });

    test('Should return an error if room list is not loaded', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.deleteRoom(newRoom.id))
          .thenAnswer((_) async => true);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      final room = await roomListProvider.deleteRoom(newRoom);
      expect(room, false);
    });

    test('Should return an error if room is not found', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(() => mockRoomRepository.getRoomList()).thenAnswer((_) async => [
            Room.empty(),
            Room.empty(),
          ]);
      when(() => mockRoomRepository.deleteRoom(newRoom.id))
          .thenAnswer((_) async => false);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      await roomListProvider.loadRooms();
      final room = await roomListProvider.deleteRoom(newRoom);
      expect(room, false);
    });
  });
}
