import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/loan_button.dart';
import 'package:myecl/loan/ui/loan_ui.dart';
import 'package:myecl/loan/ui/refresh_indicator.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AdminLoanPage extends HookConsumerWidget {
  const AdminLoanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanerId = ref.watch(loanerIdProvider);
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final loanList = ref.watch(loanerLoanListProvider);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    ref.watch(loanerProvider);
    ref.watch(userList);
    List<Widget> listWidget = [
      Container(
        margin: const EdgeInsets.only(right: 10, left: 20),
        height: 48,
        alignment: Alignment.centerLeft,
        child: const Text(
          LoanTextConstants.onGoingLoan,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    ];

    loanList.when(
      data: (data) {
        if (data.isNotEmpty) {
          List<String> categories =
              data.map((e) => e.loaner.name).toSet().toList();
          Map<String, List<Widget>> dictCateListWidget = {
            for (var item in categories) item: []
          };

          for (Loan l in data) {
            dictCateListWidget[l.loaner.name]!
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
        } else {
          listWidget.add(Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: Container(
              height: 40,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                LoanTextConstants.noLoan,
              ),
            ),
          ));
        }
      },
      loading: () {
        listWidget.add(const Center(
            child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(LoanColorConstants.darkGrey),
        )));
      },
      error: (error, s) {
        listWidget.add(Center(child: Text(error.toString())));
      },
    );

    return LoanRefresher(
      onRefresh: () async {
        await loanListNotifier.loadLoan(loanerId);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              child: const LoanCommonButton(text: LoanTextConstants.addLoan),
              onTap: () {
                pageNotifier.setLoanPage(LoanPage.addLoan);
              },
            ),
            const SizedBox(
              height: 10,
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
