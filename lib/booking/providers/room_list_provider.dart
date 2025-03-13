import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/booking/adapters/room.dart';

class RoomListNotifier extends ListNotifierAPI<RoomComplete> {
  final Openapi roomRepository;
  RoomListNotifier({required this.roomRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<RoomComplete>>> loadRooms() async {
    return await loadList(roomRepository.bookingRoomsGet);
  }

  Future<bool> addRoom(RoomBase room) async {
    return await add(() => roomRepository.bookingRoomsPost(body: room), room);
  }

  Future<bool> updateRoom(RoomComplete room) async {
    return await update(
      () => roomRepository.bookingRoomsRoomIdPatch(
        roomId: room.id,
        body: room.toRoomBase(),
      ),
      (room) => room.id,
      room,
    );
  }

  Future<bool> deleteRoom(String roomId) async {
    return await delete(
      () => roomRepository.bookingRoomsRoomIdDelete(roomId: roomId),
      (r) => r.id,
      roomId,
    );
  }
}

final roomListProvider =
    StateNotifierProvider<RoomListNotifier, AsyncValue<List<RoomComplete>>>(
        (ref) {
  final roomRepository = ref.watch(repositoryProvider);
  return RoomListNotifier(roomRepository: roomRepository)..loadRooms();
});
