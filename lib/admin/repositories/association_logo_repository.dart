import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/logo_repository.dart';

class AssociationLogoRepository extends LogoRepository {
  @override
  // ignore: overridden_fields
  final ext = "associations/";

  Future<Image> getAssociationLogo(String id) async {
    final uint8List = await getLogo("", suffix: "$id/logo");
    if (uint8List.isEmpty) {
      return Image.asset("assets/images/vache.png", fit: BoxFit.cover);
    }
    return Image.memory(uint8List);
  }

  Future<Image> addAssociationLogo(Uint8List bytes, String id) async {
    final uint8List = await addLogo(bytes, "", suffix: "$id/logo");
    return Image.memory(uint8List);
  }
}

final associationLogoRepository = Provider<AssociationLogoRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return AssociationLogoRepository()..setToken(token);
});
