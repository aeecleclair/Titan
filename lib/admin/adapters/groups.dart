import 'package:myecl/generated/openapi.models.swagger.dart';

extension $CoreGroup on CoreGroup {
  CoreGroupSimple toCoreGroupSimple() {
    return CoreGroupSimple(name: name, id: id);
  }
}