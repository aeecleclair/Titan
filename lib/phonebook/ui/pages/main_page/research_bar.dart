import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/phonebook/providers/research_filter_provider.dart';
import 'package:titan/phonebook/tools/constants.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/l10n/app_localizations.dart';

class ResearchBar extends HookConsumerWidget {
  const ResearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final editingController = useTextEditingController();
    final filterNotifier = ref.watch(filterProvider.notifier);

    return Expanded(
      child: TextField(
        onChanged: (value) {
          filterNotifier.setFilter(value);
        },
        focusNode: focusNode,
        controller: editingController,
        cursorColor: PhonebookColorConstants.textDark,
        decoration: InputDecoration(
          isDense: true,
          suffixIcon: const Icon(
            Icons.search,
            color: PhonebookColorConstants.textDark,
            size: 30,
          ),
          label: Text(
            AppLocalizations.of(context)!.phonebookResearch,
            style: const TextStyle(color: PhonebookColorConstants.textDark),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.gradient1),
          ),
        ),
      ),
    );
  }
}
