import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/class/loaner.dart';
import 'package:titan/loan/providers/admin_loan_list_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';

class LoanersBar extends HookConsumerWidget {
  final Function(Loaner) onTap;
  const LoanersBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminLoanList = ref.watch(adminLoanListProvider);
    final loaner = ref.watch(loanerProvider);
    return HorizontalListView.builder(
      height: 40,
      items: adminLoanList.keys.toList(),
      itemBuilder: (context, key, i) {
        final selected = loaner.id == key.id;
        return ItemChip(
          selected: selected,
          onTap: () async {
            onTap(key);
          },
          child: Text(
            capitalize(key.name),
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
