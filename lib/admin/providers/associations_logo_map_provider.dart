import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';

class AssociationLogoMapNotifier extends MapNotifier<String, Image> {
  AssociationLogoMapNotifier() : super();
}

final associationLogoMapProvider =
    StateNotifierProvider<
      AssociationLogoMapNotifier,
      Map<String, AsyncValue<List<Image>>?>
    >((ref) {
      AssociationLogoMapNotifier associationLogoNotifier =
          AssociationLogoMapNotifier();
      return associationLogoNotifier;
    });
