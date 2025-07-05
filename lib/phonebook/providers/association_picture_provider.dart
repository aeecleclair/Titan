import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/phonebook/providers/associations_picture_map_provider.dart';
import 'package:titan/phonebook/repositories/association_picture_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class AssociationPictureProvider extends SingleNotifier<Image> {
  final AssociationPictureRepository associationPictureRepository;
  final AssociationPictureMapNotifier associationPictureMapNotifier;
  AssociationPictureProvider({
    required this.associationPictureRepository,
    required this.associationPictureMapNotifier,
  }) : super(const AsyncLoading());

  Future<Image> getAssociationPicture(String associationId) async {
    final image = await associationPictureRepository.getAssociationPicture(
      associationId,
    );
    associationPictureMapNotifier.setTData(associationId, AsyncData([image]));
    return image;
  }

  Future<Image> updateAssociationPicture(
    String associationId,
    Uint8List bytes,
  ) async {
    final image = await associationPictureRepository.addAssociationPicture(
      bytes,
      associationId,
    );
    associationPictureMapNotifier.setTData(associationId, AsyncData([image]));
    return image;
  }
}

final associationPictureProvider =
    StateNotifierProvider<AssociationPictureProvider, AsyncValue<Image>>((ref) {
      final associationPicture = ref.watch(associationPictureRepository);
      final sessionPosterMapNotifier = ref.watch(
        associationPictureMapProvider.notifier,
      );
      return AssociationPictureProvider(
        associationPictureRepository: associationPicture,
        associationPictureMapNotifier: sessionPosterMapNotifier,
      );
    });
