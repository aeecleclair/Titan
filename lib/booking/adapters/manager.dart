import 'package:myecl/generated/openapi.models.swagger.dart';

extension $Manager on Manager {
  ManagerBase toManagerBase() {
    return ManagerBase(
      groupId: groupId,
      name: name,
    );
  }

  ManagerUpdate toManagerUpdate() {
    return ManagerUpdate(
      groupId: groupId,
      name: name,
    );
  }
}
