import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/tools/providers/map_provider.dart';

class AssociationLogoListNotifier extends MapNotifier<String, Image> {
  AssociationLogoListNotifier() : super();
}

final associationLogoListProvider =
    StateNotifierProvider<
      AssociationLogoListNotifier,
      Map<String, AsyncValue<List<Image>>?>
    >((ref) {
      AssociationLogoListNotifier associationLogoNotifier =
          AssociationLogoListNotifier();
      return associationLogoNotifier;
    });
