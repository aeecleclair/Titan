import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loan_history_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/loan_ui.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fakeData = ref.watch(loanHistoryProvider);
    List<Widget> listWidget = [
      Container(
        margin: const EdgeInsets.only(right: 10, left: 20),
        height: 48,
        alignment: Alignment.centerLeft,
        child: const Text(
          "Historique",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    ];

    fakeData.when(
      data: (data) {
        List<String> categories =
            data.map((e) => e.association).toSet().toList();
        Map<String, List<Widget>> dictCateListWidget = {
          for (var item in categories) item: []
        };

        for (Loan l in data) {
          dictCateListWidget[l.association]!.add(LoanUi(l: l, isHistory: true));
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
          valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.darkGrey),
        )));
      },
      error: (error, s) {
        listWidget.add(const Center(child: Text('Error')));
      },
    );

    return SingleChildScrollView(
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
    );
  }
}
