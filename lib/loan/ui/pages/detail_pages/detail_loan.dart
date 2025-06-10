import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/providers/loan_provider.dart';
import 'package:titan/loan/ui/pages/detail_pages/item_card_in_loan.dart';
import 'package:titan/loan/ui/loan.dart';
import 'package:titan/loan/ui/pages/admin_page/loan_card.dart';
import 'package:titan/tools/functions.dart';

class DetailLoanPage extends HookConsumerWidget {
  const DetailLoanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loan = ref.watch(loanProvider);
    return LoanTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade50,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        Container(
                          padding: const EdgeInsets.all(30.0),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                loan.borrower.getName(),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                capitalize(loan.loaner.name),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                loan.notes,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        loan.itemsQuantity.isNotEmpty
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Wrap(
                                  children: loan.itemsQuantity
                                      .map(
                                        (itemQty) =>
                                            ItemCardInLoan(itemQty: itemQty),
                                      )
                                      .toList(),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: LoanCard(loan: loan, isDetail: true)),
            ),
          ],
        ),
      ),
    );
  }
}
