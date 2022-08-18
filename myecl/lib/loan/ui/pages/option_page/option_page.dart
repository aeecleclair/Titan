import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
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
              child: Container(
                margin: const EdgeInsets.only(left: 40, right: 40, bottom: 30),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: LoanColorConstants.darkGrey,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: LoanColorConstants.darkGrey,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ]),
                child: const Text(
                  "Gestion des prêts",
                  style: TextStyle(
                    color: LoanColorConstants.veryLightOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              onTap: () {
                pageNotifier.setLoanPage(LoanPage.adminLoan);
              },
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: LoanColorConstants.darkGrey,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: LoanColorConstants.darkGrey,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ]),
                child: const Text(
                  "Gestion des objets",
                  style: TextStyle(
                    color: LoanColorConstants.veryLightOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
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
