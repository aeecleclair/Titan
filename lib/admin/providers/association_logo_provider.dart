import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/admin/providers/associations_logo_map_provider.dart';
import 'package:titan/admin/repositories/association_logo_repository.dart';
import 'package:titan/tools/providers/single_notifier.dart';

class AssociationLogoProvider extends SingleNotifier<Image> {
  final AssociationLogoRepository associationLogoRepository;
  final AssociationLogoMapNotifier associationLogoMapNotifier;
  final ImagePicker _picker = ImagePicker();

  AssociationLogoProvider({
    required this.associationLogoRepository,
    required this.associationLogoMapNotifier,
  }) : super(const AsyncLoading());

  Future<Image> getAssociationLogo(String associationId) async {
    final image = await associationLogoRepository.getAssociationLogo(
      associationId,
    );
    associationLogoMapNotifier.setTData(associationId, AsyncData([image]));
    state = AsyncData(image);
    return image;
  }

  Future<bool?> setLogo(ImageSource source, String associationId) async {
    final previousState = state;
    state = const AsyncLoading();
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 20,
    );
    if (image != null) {
      try {
        final i = await associationLogoRepository.addAssociationLogo(
          await image.readAsBytes(),
          associationId,
        );
        state = AsyncValue.data(i);
        associationLogoMapNotifier.setTData(associationId, AsyncData([i]));
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

final associationLogoProvider =
    StateNotifierProvider<AssociationLogoProvider, AsyncValue<Image>>((ref) {
      final associationLogo = ref.watch(associationLogoRepository);
      final sessionPosterMapNotifier = ref.watch(
        associationLogoMapProvider.notifier,
      );
      return AssociationLogoProvider(
        associationLogoRepository: associationLogo,
        associationLogoMapNotifier: sessionPosterMapNotifier,
      );
    });
