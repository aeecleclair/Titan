import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/l10n/app_localizations.dart';
import 'package:titan/phonebook/providers/association_groupement_list_provider.dart';
import 'package:titan/phonebook/providers/research_filter_provider.dart';
import 'package:titan/phonebook/ui/components/groupement_bar.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';

class AssociationResearchBar extends HookConsumerWidget {
  const AssociationResearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterNotifier = ref.watch(filterProvider.notifier);
    final associaiontGroupementList = ref.watch(
      associationGroupementListProvider,
    );

    final localizeWithContext = AppLocalizations.of(context)!;

    return AsyncChild(
      value: associaiontGroupementList,
      builder: (context, groupements) {
        return CustomSearchBar(
          onSearch: (value) {
            filterNotifier.setFilter(value);
          },
          onFilter: groupements.length <= 1
              ? null
              : () => showCustomBottomModal(
                  ref: ref,
                  context: context,
                  modal: BottomModalTemplate(
                    title: localizeWithContext.phonebookFilter,
                    description: localizeWithContext.phonebookFilterDescription,
                    // "Sélectionnez un ou plusieurs groupements pour filtrer les associations.",
                    actions: [
                      Button(
                        text: localizeWithContext.phonebookClose,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                      child: AssociationGroupementBar(
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
