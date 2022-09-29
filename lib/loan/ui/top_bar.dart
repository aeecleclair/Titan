import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(loanPageProvider);
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Builder(
                builder: (BuildContext appBarContext) {
                  return IconButton(
                      onPressed: () {
                        switch (page) {
                          case LoanPage.detail:
                            pageNotifier.setLoanPage(LoanPage.main);
                            break;
                          case LoanPage.editLoan:
                            pageNotifier.setLoanPage(LoanPage.groupLoan);
                            break;
                          case LoanPage.main:
                            controllerNotifier.toggle();
                            break;
                          case LoanPage.option:
                            pageNotifier.setLoanPage(LoanPage.main);
                            break;
                          case LoanPage.addLoan:
                            pageNotifier.setLoanPage(LoanPage.adminLoan);
                            break;
                          case LoanPage.addItem:
                            pageNotifier.setLoanPage(LoanPage.adminItem);
                            break;
                          case LoanPage.history:
                            pageNotifier.setLoanPage(LoanPage.main);
                            break;
                          case LoanPage.historyDetail:
                            pageNotifier.setLoanPage(LoanPage.history);
                            break;
                          case LoanPage.groupLoan:
                            pageNotifier.setLoanPage(LoanPage.adminLoan);
                            break;
                          case LoanPage.editItem:
                            pageNotifier.setLoanPage(LoanPage.adminItem);
                            break;
                          case LoanPage.adminItem:
                            pageNotifier.setLoanPage(LoanPage.option);
                            break;
                          case LoanPage.adminLoan:
                            pageNotifier.setLoanPage(LoanPage.option);
                            break;
                        }
                      },
                      icon: FaIcon(
                        page == LoanPage.main
                            ? FontAwesomeIcons.chevronRight
                            : FontAwesomeIcons.chevronLeft,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ));
                },
              ),
            ),
            const Text(
              LoanTextConstants.loan,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
      ],
    );
  }
}
