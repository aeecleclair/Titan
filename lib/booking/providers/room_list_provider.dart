import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
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
          roomId: room.id, body: room.toRoomBase()),
      (room) => room.id,
      room,
    );
  }

  Future<bool> deleteRoom(RoomComplete room) async {
    return await delete(
      () => roomRepository.bookingRoomsRoomIdDelete(roomId: room.id),
      (rooms) => rooms..removeWhere((i) => i.id == room.id),
    );
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
