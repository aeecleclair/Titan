import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';

class AssociationPictureMapNotifier extends MapNotifier<String, Image> {
  AssociationPictureMapNotifier() : super();
}

final associationPictureMapProvider =
    StateNotifierProvider<
      AssociationPictureMapNotifier,
      Map<String, AsyncValue<List<Image>>?>
    >((ref) {
      AssociationPictureMapNotifier associationPictureNotifier =
          AssociationPictureMapNotifier();
      return associationPictureNotifier;
    });
