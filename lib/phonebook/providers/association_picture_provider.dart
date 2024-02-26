
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/phonebook/repositories/association_picture_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

final associationPictureProvider =
    StateNotifierProvider<AssociationPictureNotifier, AsyncValue<Image>>((ref) {
  final token = ref.watch(tokenProvider);
  AssociationPictureNotifier notifier = AssociationPictureNotifier(token);
  return notifier;
});


class AssociationPictureNotifier extends SingleNotifier<Image> {
  final AssociationPictureRepository associationPictureRepository =
      AssociationPictureRepository();
  AssociationPictureNotifier(String token) : super(const AsyncLoading()) {
    associationPictureRepository.setToken(token);
  }

  Future<AsyncValue<Image>> getAssociationPicture(String associationId) async {
    return await load(
        () async => associationPictureRepository.getAssociationPicture(associationId));
  }

  Future<AsyncValue<Image>> updateAssociationPicture(String associationId, String path) async {
    return await load(
        () => associationPictureRepository.addAssociationPicture(path, associationId));
  }
}

