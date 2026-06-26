import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:titan/admin/providers/associations_logo_map_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/repository/repository.dart';

class AssociationLogoNotifier extends SingleNotifier<Image> {
  final ImagePicker _picker = ImagePicker();

  Openapi get repository => ref.watch(repositoryProvider);

  AssociationLogoMapNotifier get associationLogoMapNotifier =>
      ref.watch(associationLogoMapProvider.notifier);

  @override
  AsyncValue<Image> build() {
    return const AsyncLoading();
  }

  Future<Image> getAssociationLogo(String associationId) async {
    final response = await repository.associationsAssociationIdLogoGet(
      associationId: associationId,
    );
    final image = response.bodyBytes.isEmpty
        ? Image.asset("assets/images/vache.png", fit: BoxFit.cover)
        : Image.memory(response.bodyBytes);
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
        final bytes = await image.readAsBytes();
        await repository.associationsAssociationIdLogoPost(
          associationId: associationId,
          image: bytes,
        );
        final i = Image.memory(bytes);
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
    NotifierProvider<AssociationLogoNotifier, AsyncValue<Image>>(
      AssociationLogoNotifier.new,
    );
