import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/booking/adapters/room.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;
import 'package:myecl/tools/builders/empty_models.dart';

class MockRoomRepository extends Mock implements Openapi {}

void main() {
  group('RoomListNotifier', () {
    late MockRoomRepository mockRepository;
    late RoomListNotifier provider;
    final rooms = [
      EmptyModels.empty<RoomComplete>().copyWith(id: '1'),
      EmptyModels.empty<RoomComplete>().copyWith(id: '2'),
    ];
    final newRoom = EmptyModels.empty<RoomComplete>().copyWith(id: '3');
    final updatedRoom = rooms.first.copyWith(name: 'Updated Room');

    setUp(() {
      mockRepository = MockRoomRepository();
      provider = RoomListNotifier(roomRepository: mockRepository);
    });

    test('loadRooms returns expected data', () async {
      when(() => mockRepository.bookingRoomsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          rooms,
        ),
      );

      final result = await provider.loadRooms();

      expect(
        result.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        rooms,
      );
    });

    test('loadRooms handles error', () async {
      when(() => mockRepository.bookingRoomsGet())
          .thenThrow(Exception('Failed to load rooms'));

      final result = await provider.loadRooms();

      expect(
        result.maybeWhen(
          error: (error, _) => error,
          orElse: () => null,
        ),
        isA<Exception>(),
      );
    });

    test('addRoom adds a room to the list', () async {
      when(() => mockRepository.bookingRoomsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          rooms,
        ),
      );
      when(() => mockRepository.bookingRoomsPost(body: any(named: 'body')))
          .thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          newRoom,
        ),
      );

      await provider.loadRooms();
      final result = await provider.addRoom(newRoom.toRoomBase());

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [...rooms, newRoom],
      );
    });

    test('addRoom handles error', () async {
      when(() => mockRepository.bookingRoomsPost(body: any(named: 'body')))
          .thenThrow(Exception('Failed to add room'));

      final result = await provider.addRoom(newRoom.toRoomBase());

      expect(result, false);
    });

    test('updateRoom updates a room in the list', () async {
      when(() => mockRepository.bookingRoomsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          rooms,
        ),
      );
      when(
        () => mockRepository.bookingRoomsRoomIdPatch(
          roomId: any(named: 'roomId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          updatedRoom,
        ),
      );

      await provider.loadRooms();
      final result = await provider.updateRoom(updatedRoom);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        [updatedRoom, ...rooms.skip(1)],
      );
    });

    test('updateRoom handles error', () async {
      when(
        () => mockRepository.bookingRoomsRoomIdPatch(
          roomId: any(named: 'roomId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Failed to update room'));

      final result = await provider.updateRoom(updatedRoom);

      expect(result, false);
    });

    test('deleteRoom removes a room from the list', () async {
      when(() => mockRepository.bookingRoomsGet()).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          rooms,
        ),
      );
      when(
        () => mockRepository.bookingRoomsRoomIdDelete(
          roomId: any(named: 'roomId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(
          http.Response('body', 200),
          null,
        ),
      );

      await provider.loadRooms();
      final result = await provider.deleteRoom(rooms.first.id);

      expect(result, true);
      expect(
        provider.state.maybeWhen(
          data: (data) => data,
          orElse: () => [],
        ),
        rooms.skip(1).toList(),
      );
    });

    test('deleteRoom handles error', () async {
      when(
        () => mockRepository.bookingRoomsRoomIdDelete(roomId: rooms.first.id),
      ).thenThrow(Exception('Failed to delete room'));

      final result = await provider.deleteRoom(rooms.first.id);

      expect(result, false);
    });
  });
}
