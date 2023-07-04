import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/ui/components/loaner_chip.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';

class LoanersBar extends HookConsumerWidget {
  final Function(Loaner) onTap;
  const LoanersBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminLoanList = ref.watch(adminLoanListProvider);
    final loaner = ref.watch(loanerProvider);
    return adminLoanList.when(
      data: (loans) => HorizontalListView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            const SizedBox(width: 15),
            ...loans
                .map((key, value) => MapEntry(
                    LoanerChip(
                      label: capitalize(key.name),
                      selected: loaner.id == key.id,
                      onTap: () async {
                        onTap(key);
                      },
                    ),
                    value))
                .keys,
            const SizedBox(width: 15),
          ],
        ),
      ),
      error: (Object error, StackTrace stackTrace) {
        return Center(
          child: Text('Error: $error'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
