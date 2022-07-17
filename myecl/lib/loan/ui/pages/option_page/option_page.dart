import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';

class OptionPage extends HookConsumerWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: ColorConstant.darkGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Ajouter un prêt",
              style: TextStyle(
                color: ColorConstant.veryLightOrange,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          onTap: () {
            pageNotifier.setLoanPage(LoanPage.addLoan);
          },
        ),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: ColorConstant.darkGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Ajouter un objet",
              style: TextStyle(
                color: ColorConstant.veryLightOrange,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          onTap: () {
            pageNotifier.setLoanPage(LoanPage.addItem);
          },
        )
      ],
    );
  }
}
