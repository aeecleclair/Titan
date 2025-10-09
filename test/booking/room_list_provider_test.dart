import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/service/class/room.dart';
import 'package:titan/service/providers/room_list_provider.dart';
import 'package:titan/service/repositories/rooms_repository.dart';

class MockRoomRepository extends Mock implements RoomRepository {}

void main() {
  group('RoomListNotifier', () {
    test('Should load rooms', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(
        () => mockRoomRepository.getRoomList(),
      ).thenAnswer((_) async => [newRoom]);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      final rooms = await roomListProvider.loadRooms();
      expect(rooms, isA<AsyncData<List<Room>>>());
      expect(rooms.maybeWhen(data: (data) => data, orElse: () => []).length, 1);
    });

    test('Should add a room', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(
        () => mockRoomRepository.getRoomList(),
      ).thenAnswer((_) async => [Room.empty()]);
      when(
        () => mockRoomRepository.createRoom(newRoom),
      ).thenAnswer((_) async => newRoom);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      await roomListProvider.loadRooms();
      final room = await roomListProvider.addRoom(newRoom);
      expect(room, true);
    });

    test('Should update a room', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(
        () => mockRoomRepository.getRoomList(),
      ).thenAnswer((_) async => [Room.empty(), newRoom]);
      when(
        () => mockRoomRepository.updateRoom(newRoom),
      ).thenAnswer((_) async => true);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      await roomListProvider.loadRooms();
      final room = await roomListProvider.updateRoom(newRoom);
      expect(room, true);
    });

    test('Should delete a room', () async {
      final mockRoomRepository = MockRoomRepository();
      final newRoom = Room.empty().copyWith(id: "1");
      when(
        () => mockRoomRepository.getRoomList(),
      ).thenAnswer((_) async => [Room.empty(), newRoom]);
      when(
        () => mockRoomRepository.deleteRoom(newRoom.id),
      ).thenAnswer((_) async => true);
      final roomListProvider = RoomListNotifier(
        roomRepository: mockRoomRepository,
      );
      await roomListProvider.loadRooms();
      final room = await roomListProvider.deleteRoom(newRoom);
      expect(room, true);
    });
  });
}
