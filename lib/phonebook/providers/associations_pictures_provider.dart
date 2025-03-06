import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class AssociationPictureNotifier
    extends MapNotifier<AssociationComplete, Image> {
  AssociationPictureNotifier() : super();
}

final associationPicturesProvider = StateNotifierProvider<
    AssociationPictureNotifier,
    Map<AssociationComplete, AsyncValue<List<Image>>?>>((ref) {
  AssociationPictureNotifier associationPictureNotifier =
      AssociationPictureNotifier();
  ref.watch(associationListProvider).maybeWhen(
    data: (association) {
      associationPictureNotifier.loadTList(association);
      for (final l in association) {
        associationPictureNotifier.setTData(l, const AsyncValue.data([]));
      }
      return associationPictureNotifier;
    },
    orElse: () {
      associationPictureNotifier.loadTList([]);
      return associationPictureNotifier;
    },
  );
  return associationPictureNotifier;
});
