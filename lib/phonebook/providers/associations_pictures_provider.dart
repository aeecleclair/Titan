import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/tools/providers/map_provider.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class AssociationPictureNotifier extends MapNotifier<Association, Image> {
  AssociationPictureNotifier() : super();
}

final associationPicturesProvider =
    StateNotifierProvider<
      AssociationPictureNotifier,
      Map<Association, AsyncValue<List<Image>>?>
    >((ref) {
      AssociationPictureNotifier associationPictureNotifier =
          AssociationPictureNotifier();
      tokenExpireWrapperAuth(ref, () async {
        ref
            .watch(associationListProvider)
            .maybeWhen(
              data: (association) {
                associationPictureNotifier.loadTList(association);
                for (final l in association) {
                  associationPictureNotifier.setTData(
                    l,
                    const AsyncValue.data([]),
                  );
                }
                return associationPictureNotifier;
              },
              orElse: () {
                associationPictureNotifier.loadTList([]);
                return associationPictureNotifier;
              },
            );
      });
      return associationPictureNotifier;
    });
