import 'package:myecl/generated/openapi.models.swagger.dart';

extension $ModuleVisibility on ModuleVisibility {
  ModuleVisibilityCreate toModuleVisibilityCreate(String allowedGroupId) {
    return ModuleVisibilityCreate(
      root: root,
      allowedGroupId: allowedGroupId,
    );
  }
}
