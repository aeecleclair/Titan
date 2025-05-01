import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/providers/research_filter_provider.dart';
import 'package:myecl/admin/tools/constants.dart';

class ResearchBar extends HookConsumerWidget {
  const ResearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final editingController = useTextEditingController();
    final filterNotifier = ref.watch(filterProvider.notifier);

    return TextField(
      onChanged: (value) {
        filterNotifier.setFilter(value);
      },
      focusNode: focusNode,
      controller: editingController,
      cursorColor: Theme.of(context).colorScheme.secondaryContainer,
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.secondaryContainer,
          size: 30,
        ),
        label: Text(
          AdminTextConstants.research,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
        ),
      ),
    );
  }
}
