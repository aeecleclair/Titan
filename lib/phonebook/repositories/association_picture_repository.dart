import 'package:flutter/services.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class AssociationPictureRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'phonebook/associations/';

  Future<Uint8List> getAssociationPicture(String associationId) async {
   return await getLogo(associationId, suffix: "/picture");
  }

  Future<Uint8List> addAssociationPicture(String path, String associationId) async {
    final image = await saveLogoToTemp(path);
    return await addLogo(image.path, associationId, suffix: "/picture");
  }
}
