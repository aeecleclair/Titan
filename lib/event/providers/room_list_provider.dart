import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/service/class/room.dart';
import 'package:titan/service/repositories/rooms_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class RoomListNotifier extends ListNotifier<Room> {
  final RoomRepository roomRepository;
  RoomListNotifier({required this.roomRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Room>>> loadRooms() async {
    return await loadList(roomRepository.getRoomList);
  }

  Future<bool> addRoom(Room room) async {
    return await add(roomRepository.createRoom, room);
  }

  Future<bool> updateRoom(Room room) async {
    return await update(
      roomRepository.updateRoom,
      (rooms, room) => rooms..[rooms.indexWhere((r) => r.id == room.id)] = room,
      room,
    );
  }

  Future<bool> deleteRoom(Room room) async {
    return await delete(
      roomRepository.deleteRoom,
      (rooms, room) => rooms..removeWhere((i) => i.id == room.id),
      room.id,
      room,
    );
  }
}

final roomListProvider =
    StateNotifierProvider<RoomListNotifier, AsyncValue<List<Room>>>((ref) {
      final roomRepository = ref.watch(roomRepositoryProvider);
      final provider = RoomListNotifier(roomRepository: roomRepository);
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadRooms();
      });
      return provider;
    });
