import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/item_card.dart';
import 'package:myecl/tools/functions.dart';

class DetailLoanPage extends HookConsumerWidget {
  const DetailLoanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loan = ref.watch(loanProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              capitalize(loan.loaner.name),
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              formatDatesOnlyDay(loan.start, loan.end),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              loan.caution,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              loan.borrower.getName(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              loan.returned
                  ? LoanTextConstants.ended
                  : LoanTextConstants.onGoing,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              loan.notes,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            const SizedBox(width: 10),
            ...loan.items.map((e) => ItemCard(
                  item: e,
                  showButtons: false,
                  onDelete: () {},
                  onEdit: () {},
                )),
            const SizedBox(width: 10),
          ],
        ),
      ),
    ]);
  }
}
