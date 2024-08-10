import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/phonebook/providers/research_filter_provider.dart';
import 'package:myecl/purchases/tools/constants.dart';
import 'package:myecl/tools/constants.dart';

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
        cursorColor: PurchasesColorConstants.textDark,
        decoration: const InputDecoration(
          isDense: true,
          suffixIcon: Icon(
            Icons.search,
            color: PurchasesColorConstants.textDark,
            size: 30,
          ),
          label: Text(
            PurchasesTextConstants.research,
            style: TextStyle(
              color: PurchasesColorConstants.textDark,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.gradient1),
          ),
        ),
      ),
    );
  }
}
