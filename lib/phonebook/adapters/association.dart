import 'package:myecl/generated/openapi.models.swagger.dart';

extension $AssociationComplete on AssociationComplete {
  AssociationEdit toAssociationEdit() {
    return AssociationEdit(
      name: name,
      description: description,
      kind: kind,
      mandateYear: mandateYear,
    );
  }

  AssociationGroupsEdit toAssociationGroupsEdit() {
    return AssociationGroupsEdit(
      associatedGroups: associatedGroups,
    );
  }
}
