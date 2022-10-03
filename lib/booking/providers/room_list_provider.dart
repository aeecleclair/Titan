import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/repositories/rooms_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class RoomListNotifier extends ListNotifier<Room> {
  final RoomRepository _repository = RoomRepository();
  RoomListNotifier({required String token}) : super(const AsyncValue.loading()) {
    _repository.setToken(token);
  }

  Future<AsyncValue<List<Room>>> loadRooms() async {
    return await loadList(_repository.getRoomList);
  }

  Future<bool> addRoom(Room room) async {
    return await add(_repository.createRoom, room);
  }

  Future<bool> updateRoom(Room room) async {
    return await update(
        _repository.updateRoom,
        (rooms, room) => rooms
          ..[rooms.indexWhere((r) => r.id == room.id)] = room,
        room);
  }

  Future<bool> deleteRoom(Room room) async {
    return await delete(_repository.deleteRoom,
        (rooms, room) => rooms..removeWhere((i) => i.id == room.id), room.id, room);
  }
}

final roomListProvider =
    StateNotifierProvider<RoomListNotifier, AsyncValue<List<Room>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  final provider = RoomListNotifier(token: token);
  provider.loadRooms();
  return provider;
});