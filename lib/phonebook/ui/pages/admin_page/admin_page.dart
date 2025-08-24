import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/phonebook/providers/association_filtered_list_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/association_provider.dart';
import 'package:titan/phonebook/providers/phonebook_admin_provider.dart';
import 'package:titan/phonebook/providers/roles_tags_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/ui/components/association_research_bar.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/phonebook/ui/pages/admin_page/editable_association_card.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
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
    final associationNotifier = ref.watch(associationProvider.notifier);
    final associationGroupementNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );
    final associationFilteredList = ref.watch(associationFilteredListProvider);
    final roleNotifier = ref.watch(rolesTagsProvider.notifier);
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);
    final isAdmin = ref.watch(isAdminProvider);

    final localizeWithContext = AppLocalizations.of(context)!;

    return PhonebookTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await associationListNotifier.loadAssociations();
          await roleNotifier.loadRolesTags();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.phonebookAssociations,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.title,
                    ),
                  ),
                  const Spacer(),
                  CustomIconButton(
                    icon: HeroIcon(
                      HeroIcons.plus,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: isPhonebookAdmin
                        ? () {
                            associationNotifier.resetAssociation();
                            associationGroupementNotifier
                                .resetAssociationGroupement();
                            QR.to(
                              PhonebookRouter.root +
                                  PhonebookRouter.admin +
                                  PhonebookRouter.addEditAssociation,
                            );
                          }
                        : () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AssociationResearchBar(),
              const SizedBox(height: 10),
              Async2Children(
                values: Tuple2(associationList, associationGroupementList),
                builder: (context, associations, associationGroupements) {
                  return Column(
                    children: [
                      if (associations.isEmpty)
                        Center(
                          child: Text(
                            localizeWithContext.phonebookNoAssociationFound,
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
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
