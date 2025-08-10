import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/membership.dart';
import 'package:titan/phonebook/providers/association_picture_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/associations_picture_map_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

class MembershipCard extends HookConsumerWidget {
  const MembershipCard({
    super.key,
    required this.association,
    required this.membership,
  });

  final Association association;
  final Membership membership;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationPicture = ref.watch(
      associationPictureMapProvider.select((value) => value[association.id]),
    );
    final associationPictureMapNotifier = ref.watch(
      associationPictureMapProvider.notifier,
    );
    final associationPictureNotifier = ref.watch(
      associationPictureProvider.notifier,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListItem(
        title: "${association.name} - ${membership.apparentName}",
        subtitle: membership.mandateYear.toString(),
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
          QR.to(PhonebookRouter.root + PhonebookRouter.associationDetail);
        },
      ),
    );
  }
}
