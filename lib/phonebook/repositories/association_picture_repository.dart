import 'package:flutter/material.dart';
import 'package:myecl/tools/repository/logo_repository.dart';

class AssociationPictureRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'phonebook/associations/';

  Future<Image> getAssociationPicture(String associationId) async {
    final uint8List = await getLogo(associationId, suffix: "/picture");
    if (uint8List.isEmpty) {
      return Image.asset("assets/images/logo.png");
    }
    return Image.memory(uint8List);
  }

  Future<Image> addAssociationPicture(String path, String associationId) async {
    final image = await saveLogoToTemp(path);
    final uint8List = await addLogo(image.path, associationId, suffix: "/picture");
    return Image.memory(uint8List);
  }
}
