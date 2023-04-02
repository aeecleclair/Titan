import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/booking/class/room.dart';
import 'package:myecl/event/providers/event_provider.dart';

class IsRoomNotifier extends StateNotifier<bool> {
  IsRoomNotifier(bool b) : super(b);

  void setbool(bool b) {
    state = b;
  }
}

final isRoomProvider = StateNotifierProvider<IsRoomNotifier, bool>((ref) {
  final event = ref.watch(eventProvider);
  return IsRoomNotifier(event.roomId != Room.empty().id);
});
