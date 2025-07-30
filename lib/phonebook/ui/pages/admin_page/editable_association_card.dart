import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/class/association.dart';
import 'package:titan/phonebook/class/association_groupement.dart';
import 'package:titan/phonebook/providers/association_picture_provider.dart';
import 'package:titan/phonebook/providers/associations_picture_map_provider.dart';
import 'package:titan/phonebook/ui/pages/admin_page/edition_modal.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

class EditableAssociationCard extends HookConsumerWidget {
  final Association association;
  final AssociationGroupement groupement;
  final bool isPhonebookAdmin;
  const EditableAssociationCard({
    super.key,
    required this.association,
    required this.groupement,
    required this.isPhonebookAdmin,
  });

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
    return AutoLoaderChild(
      group: associationPicture,
      notifier: associationPictureMapNotifier,
      mapKey: association.id,
      loader: (associationId) =>
          associationPictureNotifier.getAssociationPicture(associationId),
      dataBuilder: (context, data) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListItem(
            title: association.name,
            subtitle: groupement.name,
            icon: CircleAvatar(child: Image(image: data.first.image)),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return AssociationEditionModal(
                    association: association,
                    groupement: groupement,
                    isPhonebookAdmin: isPhonebookAdmin,
                  );
                },
              );
            },
          ),
        );
      },
      errorBuilder: (error, stack) =>
          const Center(child: HeroIcon(HeroIcons.exclamationCircle)),
    );
  }
}
