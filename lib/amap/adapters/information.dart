import 'package:myecl/generated/openapi.models.swagger.dart';

extension $Information on Information {
  InformationEdit toInformationEdit() {
    return InformationEdit(
      manager: manager,
      link: link,
      description: description,
    );
  }
}
