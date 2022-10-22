import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/is_loan_admin_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_list_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/loan_card.dart';
import 'package:myecl/loan/ui/loan_ui.dart';
import 'package:myecl/loan/ui/pages/detail_page/delay_dialog.dart';
import 'package:myecl/loan/ui/pages/new_admin_page/loaner_chip.dart';
import 'package:myecl/loan/ui/refresh_indicator.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final loanList = ref.watch(loanListProvider);
    final loanListNotifier = ref.watch(loanListProvider.notifier);
    final isAdmin = ref.watch(isLoanAdmin);
    final loaner = ref.watch(loanerProvider);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final loanerNotifier = ref.watch(loanerIdProvider.notifier);
    final loanerListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final adminloanListNotifier = ref.watch(adminLoanListProvider.notifier);
    ref.watch(adminLoanListProvider);
    ref.watch(itemListProvider);
    ref.watch(loanerLoanListProvider);
    List<Loaner> categories = [];
    Map<Loaner, List<List<Loan>>> dictCateListWidget = {};


    loanList.when(
      data: (data) {
        if (data.isNotEmpty) {
          categories = data.map((e) => e.loaner).toSet().toList();
          dictCateListWidget = {
            for (var item in data) item.loaner: [[], []]
          };

          for (Loan l in data) {
            if (l.returned) {
              dictCateListWidget[l.loaner]![1].add(l);
            } else {
              dictCateListWidget[l.loaner]![0].add(l);
            }
          }
        }
      },
      loading: () {},
      error: (error, s) {},
    );

    return LoanRefresher(
        onRefresh: () async {
          await loanListNotifier.loadLoanList();
        },
        child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(LoanTextConstants.loan,
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold)),
                      if (isAdmin)
                        GestureDetector(
                          onTap: () {
                            pageNotifier.setLoanPage(LoanPage.admin);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5))
                                ]),
                            child: Row(
                              children: const [
                                HeroIcon(HeroIcons.userGroup,
                                    color: Colors.white),
                                SizedBox(width: 10),
                                Text("Admin",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 15),
                    ...categories.map((e) => LoanerChip(
                        label: e.name,
                        selected: false,
                        onTap: () {
                          loanerNotifier.setId(e.id);
                        })),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              (dictCateListWidget.containsKey(loaner))
                  ? Column(children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(LoanTextConstants.onGoingLoan,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 205, 205, 205))),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            ...dictCateListWidget[loaner]![0]
                                .map((e) => LoanCard(
                                      loan: e,
                                      onEdit: () {},
                                      onCalendar: () {},
                                      onReturn: () async {},
                                    )),
                            const SizedBox(width: 10),
                          ],
                        ),
                      )
                    ])
                  : const Center(
                      child: Text(LoanTextConstants.noLoan,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 205, 205, 205)))),
              const SizedBox(height: 30),
              if (dictCateListWidget.containsKey(loaner))
                Column(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(LoanTextConstants.returnedLoan,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 205, 205, 205))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        ...dictCateListWidget[loaner]![1]
                            .map((e) => LoanCard(
                                  loan: e,
                                  onEdit: () {},
                                  onCalendar: () {},
                                  onReturn: () async {},
                                ))
                            .toList(),
                        const SizedBox(width: 10),
                      ],
                    ),
                  )
                ])
            ])));
  }
}
