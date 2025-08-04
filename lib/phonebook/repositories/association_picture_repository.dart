import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/logo_repository.dart';

class AssociationPictureRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = 'phonebook/associations/';

  Future<Image> getAssociationPicture(String associationId) async {
    final uint8List = await getLogo(associationId, suffix: "/picture");
    if (uint8List.isEmpty) {
      return Image.asset('assets/images/vache.png');
    }
    return Image.memory(uint8List);
  }

  Future<Image> addAssociationPicture(
    Uint8List bytes,
    String associationId,
  ) async {
    final uint8List = await addLogo(bytes, associationId, suffix: "/picture");
    return Image.memory(uint8List);
  }
}

final associationPictureRepository = Provider<AssociationPictureRepository>((
  ref,
) {
  final token = ref.watch(tokenProvider);
  return AssociationPictureRepository()..setToken(token);
});
