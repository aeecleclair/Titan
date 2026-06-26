import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationPictureRepository {
  final Openapi client;
  AssociationPictureRepository(this.client);

  Future<Image> getAssociationPicture(String id) async {
    final response = await client.phonebookAssociationsAssociationIdPictureGet(
      associationId: id,
    );
    final bytes = response.bodyBytes;
    if (bytes.isEmpty) {
      return Image.asset(getTitanLogo());
    }
    return Image.memory(bytes);
  }

  Future<Image> addAssociationPicture(Uint8List bytes, String id) async {
    await client.phonebookAssociationsAssociationIdPicturePost(
      associationId: id,
      image: bytes,
    );
    return Image.memory(bytes);
  }
}

final associationPictureRepositoryProvider =
    Provider<AssociationPictureRepository>(
      (ref) => AssociationPictureRepository(ref.watch(repositoryProvider)),
    );
