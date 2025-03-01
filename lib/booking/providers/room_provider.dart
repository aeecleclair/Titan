import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';

class RoomNotifier extends StateNotifier<RoomComplete> {
  RoomNotifier() : super(RoomComplete.fromJson({}));

  void setRoom(RoomComplete room) {
    state = room;
  }
}

final roomProvider = StateNotifierProvider<RoomNotifier, RoomComplete>((ref) {
  return RoomNotifier();
});
