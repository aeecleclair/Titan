import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/providers/research_filter_provider.dart';
import 'package:titan/phonebook/ui/components/groupement_bar.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/searchbar.dart';

class AssociationResearchBar extends HookConsumerWidget {
  const AssociationResearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterNotifier = ref.watch(filterProvider.notifier);

    return Expanded(
      child: CustomSearchBar(
        onSearch: (value) {
          filterNotifier.setFilter(value);
        },
        onFilter: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return BottomModalTemplate(
              title: "Groupements d'associations",
              description:
                  "Sélectionnez un ou plusieurs groupements pour filtrer les associations.",
              actions: [
                Button(text: "Fermer", onPressed: () => Navigator.pop(context)),
              ],
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                child: AssociationGroupementBar(),
              ),
            );
          },
        ),
      ),
    );
  }
}
