import 'package:myecl/generated/openapi.models.swagger.dart';

extension $RoomComplete on RoomComplete {
  RoomBase toRoomBase() {
    return RoomBase(
      managerId: managerId,
      name: name,
    );
  }
}