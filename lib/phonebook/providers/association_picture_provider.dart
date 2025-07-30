import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/phonebook/providers/associations_picture_map_provider.dart';
import 'package:titan/phonebook/repositories/association_picture_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class AssociationPictureProvider extends SingleNotifier<Image> {
  final AssociationPictureRepository associationPictureRepository;
  final AssociationPictureMapNotifier associationPictureMapNotifier;
  final ImagePicker _picker = ImagePicker();

  AssociationPictureProvider({
    required this.associationPictureRepository,
    required this.associationPictureMapNotifier,
  }) : super(const AsyncLoading());

  Future<Image> getAssociationPicture(String associationId) async {
    final image = await associationPictureRepository.getAssociationPicture(
      associationId,
    );
    associationPictureMapNotifier.setTData(associationId, AsyncData([image]));
    state = AsyncData(image);
    return image;
  }

  Future<bool?> setProfilePicture(
    ImageSource source,
    String associationId,
  ) async {
    final previousState = state;
    state = const AsyncLoading();
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 20,
    );
    if (image != null) {
      try {
        final i = await associationPictureRepository.addAssociationPicture(
          await image.readAsBytes(),
          associationId,
        );
        state = AsyncValue.data(i);
        associationPictureMapNotifier.setTData(associationId, AsyncData([i]));
        return true;
      } catch (e) {
        state = previousState;
        return false;
      }
    }
    state = previousState;
    return null;
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
