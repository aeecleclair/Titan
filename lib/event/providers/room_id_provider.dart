import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/booking/providers/room_list_provider.dart';
import 'package:myecl/event/providers/event_provider.dart';

class RoomIdNotifier extends StateNotifier<String> {
  RoomIdNotifier(String b) : super(b);

  void setRoomId(String b) {
    state = b;
  }
}

final roomIdProvider = StateNotifierProvider<RoomIdNotifier, String>((ref) {
  final event = ref.watch(eventProvider);
  final rooms = ref.watch(roomListProvider);
  final id = rooms.when(
      data: (data) => data
          .firstWhere(
            (element) => element.name == event.location,
            orElse: () => Room.empty(),
          )
          .id,
      loading: () => "",
      error: (e, s) => "");
  return RoomIdNotifier(id);
});
