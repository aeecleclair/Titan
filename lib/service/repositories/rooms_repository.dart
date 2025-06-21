import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/service/class/room.dart';
import 'package:myecl/tools/repository/repository.dart';

class RoomRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'booking/rooms';

  Future<List<Room>> getRoomList() async {
    return List<Room>.from((await getList()).map((x) => Room.fromJson(x)));
  }

  Future<Room> createRoom(Room room) async {
    return Room.fromJson(await create(room.toJson()));
  }

  Future<bool> updateRoom(Room room) async {
    return await update(room.toJson(), "/${room.id}");
  }

  Future<bool> deleteRoom(String roomId) async {
    return await delete("/$roomId");
  }
}

final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return RoomRepository()..setToken(token);
});
