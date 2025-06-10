import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/phonebook/repositories/association_picture_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

final associationPictureProvider =
    StateNotifierProvider<AssociationPictureNotifier, AsyncValue<Image>>((ref) {
      final token = ref.watch(tokenProvider);
      AssociationPictureNotifier notifier = AssociationPictureNotifier(
        token: token,
      );
      return notifier;
    });

class AssociationPictureNotifier extends SingleNotifier<Image> {
  final AssociationPictureRepository associationPictureRepository =
      AssociationPictureRepository();
  AssociationPictureNotifier({required String token})
    : super(const AsyncLoading()) {
    associationPictureRepository.setToken(token);
  }

  Future<Image> getAssociationPicture(String associationId) async {
    return await associationPictureRepository.getAssociationPicture(
      associationId,
    );
  }

  Future<Image> updateAssociationPicture(
    String associationId,
    Uint8List bytes,
  ) async {
    return await associationPictureRepository.addAssociationPicture(
      bytes,
      associationId,
    );
  }
}
