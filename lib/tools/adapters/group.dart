import 'package:myecl/generated/openapi.swagger.dart';

CoreGroupSimple coreGroupSimpleAdapter(CoreGroup coreGroup) {
  return CoreGroupSimple(
    id: coreGroup.id,
    name: coreGroup.name,
    description: coreGroup.description,
  );
}
