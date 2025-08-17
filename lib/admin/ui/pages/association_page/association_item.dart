import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/class/assocation.dart';
import 'package:titan/admin/providers/all_groups_list_provider.dart';
import 'package:titan/admin/providers/association_logo_provider.dart';
import 'package:titan/admin/providers/associations_logo_map_provider.dart';
import 'package:titan/admin/ui/pages/association_page/edit_association.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/tools/ui/builders/auto_loader_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';

class AssociationItem extends HookConsumerWidget {
  const AssociationItem({super.key, required this.association});

  final Association association;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(allGroupList);
    final group = groups.firstWhere((group) => group.id == association.groupId);
    final associationLogo = ref.watch(
      associationLogoMapProvider.select((value) => value[association.id]),
    );
    final associationLogoMapNotifier = ref.watch(
      associationLogoMapProvider.notifier,
    );
    final associationLogoNotifier = ref.watch(associationLogoProvider.notifier);

    final localizeWithContext = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListItem(
        title: association.name,
        subtitle: localizeWithContext.adminManagerGroup(group.name),
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
        onTap: () async {
          associationLogoNotifier.getAssociationLogo(association.id);
          await showCustomBottomModal(
            context: context,
            ref: ref,
            modal: BottomModalTemplate(
              title: localizeWithContext.adminEditAssociation(association.name),
              child: EditAssociation(association: association, group: group),
            ),
          );
        },
      ),
    );
  }
}
