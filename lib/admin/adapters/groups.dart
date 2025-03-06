import 'package:myecl/generated/openapi.models.swagger.dart';

extension $CoreGroup on CoreGroup {
  CoreGroupSimple toCoreGroupSimple() {
    return CoreGroupSimple(name: name, id: id);
  }
}

extension $CoreGroupSimple on CoreGroupSimple {
  CoreGroupUpdate toCoreGroupUpdate() {
    return CoreGroupUpdate(
      name: name,
      description: description,
    );
  }
}
