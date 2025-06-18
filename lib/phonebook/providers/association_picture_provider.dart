import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/phonebook/repositories/association_picture_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

final associationPictureProvider =
    StateNotifierProvider<AssociationPictureNotifier, AsyncValue<Image>>((ref) {
      final associationPictureRepository = AssociationPictureRepository(ref);
      AssociationPictureNotifier notifier = AssociationPictureNotifier(
        associationPictureRepository,
      );
      return notifier;
    });

class AssociationPictureNotifier extends SingleNotifier<Image> {
  AssociationPictureNotifier(this.associationPictureRepository)
    : super(const AsyncLoading());

  final AssociationPictureRepository associationPictureRepository;

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
