import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/loan_button.dart';
import 'package:myecl/loan/ui/pages/detail_page/button.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class OptionPage extends HookConsumerWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    ref.watch(loanerProvider);
    ref.watch(userList);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Administrateur",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          child: const LoanCommonButton(
            text: "Gestion des prêts",
          ),
          onTap: () {
            pageNotifier.setLoanPage(LoanPage.adminLoan);
          },
        ),
        GestureDetector(
          child: const LoanCommonButton(text: "Gestion des objets"),
          onTap: () {
            pageNotifier.setLoanPage(LoanPage.adminItem);
          },
        ),
        const SizedBox(),
        const SizedBox()
      ],
    );
  }
}
