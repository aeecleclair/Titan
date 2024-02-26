import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/association_kind_provider.dart';
import 'package:myecl/phonebook/providers/association_list_provider.dart';
import 'package:myecl/phonebook/providers/research_filter_provider.dart';
import 'package:myecl/phonebook/tools/constants.dart';
import 'package:myecl/tools/constants.dart';

class ResearchBar extends HookConsumerWidget {
  const ResearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final editingController = useTextEditingController();
    final filterNotifier = ref.watch(filterProvider.notifier);
    final associationsNotifier = ref.watch(associationListProvider.notifier);
    final associationKind = ref.watch(associationKindProvider);

    return Expanded(
        child: TextField(
      onChanged: (value) {
        associationsNotifier.filterAssociationList(value, associationKind);
        filterNotifier.setFilter(value);
      },
      focusNode: focusNode,
      controller: editingController,
      cursorColor: PhonebookColorConstants.textDark,
      decoration: const InputDecoration(
          isDense: true,
          suffixIcon: Icon(
            Icons.search,
            color: PhonebookColorConstants.textDark,
            size: 30,
          ),
          label: Text(
            PhonebookTextConstants.research,
            style: TextStyle(
              color: PhonebookColorConstants.textDark,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.gradient1))),
    ));
  }
}
