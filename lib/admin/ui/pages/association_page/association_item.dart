import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/providers/assocation_list_provider.dart';
import 'package:titan/admin/providers/association_logo_provider.dart';
import 'package:titan/admin/providers/associations_logo_map_provider.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

class AssociationItem extends HookConsumerWidget {
  const AssociationItem({super.key, required this.association});

  final Association association;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationLogo = ref.watch(
      associationLogoMapProvider.select((value) => value[association.id]),
    );
    final associationLogoMapNotifier = ref.watch(
      associationLogoMapProvider.notifier,
    );
    final associationLogoNotifier = ref.watch(associationLogoProvider.notifier);
    final associationNotifier = ref.watch(associationListProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListItem(
        title: association.name,
        icon: AutoLoaderChild(
          group: associationLogo,
          notifier: associationLogoMapNotifier,
          mapKey: association.id,
          loader: (associationId) =>
              associationLogoNotifier.getAssociationLogo(associationId),
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
          associationLogoNotifier.getAssociationLogo(association.id);
        },
      ),
    );
  }
}
