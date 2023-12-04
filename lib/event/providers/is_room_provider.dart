import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/event/providers/event_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class IsRoomNotifier extends StateNotifier<bool> {
  IsRoomNotifier(bool b) : super(b);

  void setIsRoom(bool b) {
    state = b;
  }
}

final isRoomProvider = StateNotifierProvider<IsRoomNotifier, bool>((ref) {
  final event = ref.watch(eventProvider);
  return IsRoomNotifier(event.location != RoomComplete.fromJson({}).id);
});
