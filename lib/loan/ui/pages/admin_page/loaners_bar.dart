import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/all_loaner_list_provider.dart';
import 'package:myecl/loan/providers/selected_loaner_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';

class LoanersBar extends HookConsumerWidget {
  final Function(Loaner) onTap;
  const LoanersBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaners = ref.watch(allLoanerListProvider);
    final selectedLoaner = ref.watch(selectedLoanerProvider);
    return HorizontalListView.builder(
      height: 40,
      items: loaners,
      itemBuilder: (context, loaner, i) {
        final selected = selectedLoaner.id == loaner.id;
        return ItemChip(
          selected: selected,
          onTap: () async {
            onTap(loaner);
          },
          child: Text(
            capitalize(loaner.name),
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
