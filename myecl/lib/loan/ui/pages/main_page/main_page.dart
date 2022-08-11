import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loan_list_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/loan_ui.dart';
import 'package:myecl/loan/ui/refresh_indicator.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final loanList = ref.watch(loanListProvider);
    final loanListNotifier = ref.watch(loanListProvider.notifier);
    List<Widget> listWidget = [
      Container(
          margin: const EdgeInsets.only(right: 10, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "En cours",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      pageNotifier.setLoanPage(LoanPage.history);
                    },
                    icon: const HeroIcon(
                      HeroIcons.clipboardList,
                      color: LoanColorConstants.lightGrey,
                      size: 25,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pageNotifier.setLoanPage(LoanPage.option);
                    },
                    icon: const HeroIcon(
                      HeroIcons.plus,
                      color: LoanColorConstants.lightGrey,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ],
          ))
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
              .add(LoanUi(l: l, isHistory: false, isAdmin: false));
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
        loanListNotifier.loadLoanList();
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
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
