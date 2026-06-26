import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/booking/adapters/room.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class RoomListNotifier extends ListNotifierAPI<RoomComplete> {
  Openapi get roomRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<RoomComplete>> build() {
    loadRooms();
    return const AsyncValue.loading();
  }

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

  Future<bool> deleteRoom(RoomComplete room) async {
    return await delete(
      () => roomRepository.bookingRoomsRoomIdDelete(roomId: room.id),
      (room) => room.id,
      room.id,
    );
  }
}

final roomListProvider =
    NotifierProvider<RoomListNotifier, AsyncValue<List<RoomComplete>>>(
      RoomListNotifier.new,
    );
