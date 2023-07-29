import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/layouts/item_chip.dart';

class LoanersBar extends HookConsumerWidget {
  final Function(Loaner) onTap;
  const LoanersBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminLoanList = ref.watch(adminLoanListProvider);
    final loaner = ref.watch(loanerProvider);
    return AsyncChild(
      value: adminLoanList,
      builder: (context, loans) => HorizontalListView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 15),
            ...loans.map((key, value) {
              final selected = loaner.id == key.id;
              return MapEntry(
                  ItemChip(
                    selected: selected,
                    onTap: () async {
                      onTap(key);
                    },
                    child: Text(
                      capitalize(key.name),
                      style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  value);
            }).keys,
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
