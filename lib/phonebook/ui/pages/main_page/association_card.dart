import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_picture_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/associations_picture_map_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

class AssociationCard extends HookConsumerWidget {
  const AssociationCard({
    super.key,
    required this.association,
    required this.groupement,
  });

  final Association association;
  final AssociationGroupement groupement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationPicture = ref.watch(
      associationPictureMapProvider.select((value) => value[association.id]),
    );
    final associationPictureMapNotifier = ref.watch(
      associationPictureMapProvider.notifier,
    );
    final associationPictureNotifier = ref.watch(
      associationPictureProvider.notifier,
    );
    final associationGroupementNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );
    final associationNotifier = ref.watch(associationProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListItem(
        title: association.name,
        subtitle: groupement.name,
        icon: AutoLoaderChild(
          group: associationPicture,
          notifier: associationPictureMapNotifier,
          mapKey: association.id,
          loader: (associationId) =>
              associationPictureNotifier.getAssociationPicture(associationId),
          dataBuilder: (context, data) {
            return CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: Image(image: data.first.image).image,
            );
          },
        ),
        onTap: () {
          associationNotifier.setAssociation(association);
          associationPictureNotifier.getAssociationPicture(association.id);
          associationGroupementNotifier.setAssociationGroupement(groupement);
          QR.to(PhonebookRouter.root + PhonebookRouter.associationDetail);
        },
      ),
    );
  }
}
