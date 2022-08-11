import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/ui/refresh_indicator.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loan_list_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/loan_ui.dart';

class OptionPage extends HookConsumerWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final loanList = ref.watch(loanListProvider);
    final loanListNotifier = ref.watch(loanListProvider.notifier);
    List<Widget> listWidget = [
      Container(
        margin: const EdgeInsets.only(right: 10, left: 20),
        height: 48,
        alignment: Alignment.centerLeft,
        child: const Text(
          "Prêt en cours",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    ];

    loanList.when(
      data: (data) {
        List<String> categories =
            data.map((e) => e.association).toSet().toList();
        Map<String, List<Widget>> dictCateListWidget = {
          for (var item in categories) item: []
        };

        for (Loan l in data) {
          dictCateListWidget[l.association]!
              .add(LoanUi(l: l, isHistory: true, isAdmin: true));
        }

        for (String c in categories) {
          listWidget.add(Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  c,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )));

          listWidget += dictCateListWidget[c] ?? [];
        }
      },
      loading: () {
        listWidget.add(const Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(LoanColorConstants.darkGrey),
        )));
      },
      error: (error, s) {
        listWidget.add(Center(child: Text(error.toString())));
      },
    );

    return LoanRefresher(
      keyRefresh: GlobalKey<RefreshIndicatorState>(),
      onRefresh: () async {
        await loanListNotifier.loadLoanList();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                GestureDetector(
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 40, right: 40, bottom: 30),
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
                      "Ajouter un prêt",
                      style: TextStyle(
                        color: LoanColorConstants.veryLightOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  onTap: () {
                    pageNotifier.setLoanPage(LoanPage.addLoan);
                  },
                ),
                const SizedBox(
                  height: 20,
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
                      "Ajouter un objet",
                      style: TextStyle(
                        color: LoanColorConstants.veryLightOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  onTap: () {
                    pageNotifier.setLoanPage(LoanPage.addItem);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ...listWidget,
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
