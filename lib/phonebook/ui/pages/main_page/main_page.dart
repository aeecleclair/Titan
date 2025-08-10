import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/admin/providers/is_admin_provider.dart';
import 'package:titan/phonebook/providers/association_filtered_list_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_provider.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/providers/association_list_provider.dart';
import 'package:titan/phonebook/providers/phonebook_admin_provider.dart';
import 'package:titan/phonebook/router.dart';
import 'package:titan/phonebook/ui/pages/main_page/association_card.dart';
import 'package:titan/phonebook/ui/phonebook.dart';
import 'package:titan/phonebook/ui/components/association_research_bar.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/refresher.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:tuple/tuple.dart';

class PhonebookMainPage extends HookConsumerWidget {
  const PhonebookMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPhonebookAdmin = ref.watch(isPhonebookAdminProvider);
    final isAdmin = ref.watch(isAdminProvider);
    final associationListNotifier = ref.watch(associationListProvider.notifier);
    final associationList = ref.watch(associationListProvider);
    final associationGroupementList = ref.watch(
      associationGroupementListProvider,
    );
    final associationFilteredList = ref.watch(associationFilteredListProvider);
    final associationGroupementListNotifier = ref.watch(
      associationGroupementListProvider.notifier,
    );
    final associationGroupementNotifier = ref.watch(
      associationGroupementProvider.notifier,
    );

    final localizeWithContext = AppLocalizations.of(context)!;

    return PhonebookTemplate(
      child: Refresher(
        controller: ScrollController(),
        onRefresh: () async {
          await associationGroupementListNotifier.loadAssociationGroupement();
          await associationListNotifier.loadAssociations();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: AssociationResearchBar()),
                  if (isPhonebookAdmin || isAdmin) ...[
                    SizedBox(width: 10),
                    CustomIconButton(
                      icon: HeroIcon(
                        HeroIcons.cog6Tooth,
                        color: Colors.white,
                        size: 32,
                        style: HeroIconStyle.outline,
                      ),
                      onPressed: () {
                        associationGroupementNotifier
                            .resetAssociationGroupement();
                        QR.to(PhonebookRouter.root + PhonebookRouter.admin);
                      },
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 10),
              Async2Children(
                values: Tuple2(associationList, associationGroupementList),
                builder: (context, associations, associationGroupements) {
                  if (associations.isEmpty) {
                    return Center(
                      child: Text(
                        localizeWithContext.phonebookNoAssociationFound,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      ...associationFilteredList.map(
                        (association) => !association.deactivated
                            ? AssociationCard(
                                association: association,
                                groupement: associationGroupements.firstWhere(
                                  (groupement) =>
                                      groupement.id == association.groupementId,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
