import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/phonebook/providers/association_filtered_list_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/phonebook_admin_provider.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/ui/components/association_research_bar.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/phonebook/ui/pages/admin_page/editable_association_card.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/tools/ui/styleguide/list_item.dart';
import 'package:tuple/tuple.dart';
import 'package:titan/l10n/app_localizations.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final associationGroupementList = ref.watch(
      associationGroupementListProvider,
    );
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationList = ref.watch(associationListProvider);
    final associationFilteredList = ref.watch(associationFilteredListProvider);
    final roleNotifier = ref.watch(rolesTagsProvider.notifier);
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);
    final isAdmin = ref.watch(isAdminProvider);

    return PhonebookTemplate(
      child: Refresher(
        onRefresh: () async {
          await associationListNotifier.loadAssociations();
          await roleNotifier.loadRolesTags();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              AssociationResearchBar(),
              Async2Children(
                values: Tuple2(associationList, associationGroupementList),
                builder: (context, associations, associationGroupements) {
                  return Column(
                    children: [
                      ListItem(
                        title: "Ajouter une association",
                        icon: HeroIcon(
                          HeroIcons.plus,
                          size: 40,
                          color: Colors.grey.shade500,
                        ),
                        onTap: isPhonebookAdmin
                            ? () {
                                QR.to(
                                  PhonebookRouter.root +
                                      PhonebookRouter.admin +
                                      PhonebookRouter.addEditAssociation,
                                );
                              }
                            : null,
                      ),
                      SizedBox(height: 5),
                      if (associations.isEmpty)
                        Center(
                          child: Text(
                            AppLocalizations.of(
                              context,
                            )!.phonebookNoAssociationFound,
                          ),
                        )
                      else
                        ...associationFilteredList.map(
                          (association) => EditableAssociationCard(
                            association: association,
                            groupement: associationGroupements.firstWhere(
                              (groupement) =>
                                  groupement.id == association.groupementId,
                            ),
                            isPhonebookAdmin: isPhonebookAdmin,
                            isAdmin: isAdmin,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
