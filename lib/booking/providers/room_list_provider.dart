import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class RoomListNotifier extends ListNotifier2<RoomComplete> {
  final Openapi roomRepository;
  RoomListNotifier({required this.roomRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<RoomComplete>>> loadRooms() async {
    return await loadList(roomRepository.bookingRoomsGet);
  }

  Future<bool> addRoom(RoomComplete room) async {
    return await add(
        (room) async => roomRepository.bookingRoomsPost(
                body: RoomBase(
              managerId: room.managerId,
              name: room.name,
            )),
        room);
  }

  Future<bool> updateRoom(RoomComplete room) async {
    return await update(
        (room) async => roomRepository.bookingRoomsRoomIdPatch(
            roomId: room.id,
            body: RoomBase(
              managerId: room.managerId,
              name: room.name,
            )),
        (rooms, room) =>
            rooms..[rooms.indexWhere((r) => r.id == room.id)] = room,
        room);
  }

  Future<bool> deleteRoom(RoomComplete room) async {
    return await delete(
        (roomId) async =>
            roomRepository.bookingRoomsRoomIdDelete(roomId: roomId),
        (rooms, room) => rooms..removeWhere((i) => i.id == room.id),
        room.id,
        room);
  }
}

final roomListProvider =
    StateNotifierProvider<RoomListNotifier, AsyncValue<List<RoomComplete>>>(
        (ref) {
  final roomRepository = ref.watch(repositoryProvider);
  final provider = RoomListNotifier(roomRepository: roomRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadRooms();
  });
  return provider;
});
