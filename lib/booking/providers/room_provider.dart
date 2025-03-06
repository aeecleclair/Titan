import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

class RoomNotifier extends StateNotifier<RoomComplete> {
  RoomNotifier() : super(EmptyModels.empty<RoomComplete>());

  void setRoom(RoomComplete room) {
    state = room;
  }
}

final roomProvider = StateNotifierProvider<RoomNotifier, RoomComplete>((ref) {
  return RoomNotifier();
});
