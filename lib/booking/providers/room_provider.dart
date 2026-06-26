import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class RoomNotifier extends Notifier<RoomComplete> {
  @override
  RoomComplete build() {
    return RoomComplete.empty();
  }

  void setRoom(RoomComplete room) {
    state = room;
  }
}

final roomProvider = NotifierProvider<RoomNotifier, RoomComplete>(
  RoomNotifier.new,
);
