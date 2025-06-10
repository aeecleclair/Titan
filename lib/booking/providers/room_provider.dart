import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/service/class/room.dart';

class RoomNotifier extends StateNotifier<Room> {
  RoomNotifier() : super(Room.empty());

  void setRoom(Room room) {
    state = room;
  }
}

final roomProvider = StateNotifierProvider<RoomNotifier, Room>((ref) {
  return RoomNotifier();
});
