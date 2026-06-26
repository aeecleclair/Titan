import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationLogoRepository {
  final Openapi client;
  AssociationLogoRepository(this.client);

  Future<Image> getAssociationLogo(String id) async {
    final response = await client.associationsAssociationIdLogoGet(
      associationId: id,
    );
    final bytes = response.bodyBytes;
    if (bytes.isEmpty) {
      return Image.asset("assets/images/vache.png", fit: BoxFit.cover);
    }
    return Image.memory(bytes);
  }

  Future<Image> addAssociationLogo(Uint8List bytes, String id) async {
    await client.associationsAssociationIdLogoPost(
      associationId: id,
      image: bytes,
    );
    return Image.memory(bytes);
  }
}

final associationLogoRepository = Provider<AssociationLogoRepository>(
  (ref) => AssociationLogoRepository(ref.watch(repositoryProvider)),
);
