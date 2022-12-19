import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
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
          height: 15,
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
                          case LoanPage.main:
                            controllerNotifier.toggle();
                            break;
                          case LoanPage.addEditLoan:
                            pageNotifier.setLoanPage(LoanPage.admin);
                            break;
                          case LoanPage.addEditItem:
                            pageNotifier.setLoanPage(LoanPage.admin);
                            break;
                          case LoanPage.admin:
                            pageNotifier.setLoanPage(LoanPage.main);
                            break;
                          case LoanPage.detailLoanFromMain:
                            pageNotifier.setLoanPage(LoanPage.main);
                            break;
                          case LoanPage.detailLoanFromAdmin:
                            pageNotifier.setLoanPage(LoanPage.admin);
                            break;
                        }
                      },
                      icon: HeroIcon(
                        page == LoanPage.main
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(LoanTextConstants.loan,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            const SizedBox(
              width: 70,
            ),
          ],
        ),
      ],
    );
  }
}
