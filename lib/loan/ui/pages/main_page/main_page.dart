import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/is_loan_admin_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_list_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/loan_card.dart';
import 'package:myecl/tools/ui/refresher.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final loanList = ref.watch(loanListProvider);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final loanListNotifier = ref.watch(loanListProvider.notifier);
    final isAdmin = ref.watch(isLoanAdmin);
    ref.watch(adminLoanListProvider);
    ref.watch(itemListProvider);
    ref.watch(loanerLoanListProvider);
    List<List<Loan>> dictCateListWidget = [[], []];

    loanList.when(
      data: (data) {
        if (data.isNotEmpty) {
          for (Loan l in data) {
            if (l.returned) {
              dictCateListWidget[1].add(l);
            } else {
              dictCateListWidget[0].add(l);
            }
          }
        }
      },
      loading: () {},
      error: (error, s) {},
    );

    return Stack(
      children: [
        Refresher(
            onRefresh: () async {
              await loanListNotifier.loadLoanList();
            },
            child: Column(children: [
              const SizedBox(height: 10),
              (dictCateListWidget[0].isNotEmpty)
                  ? Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '${dictCateListWidget[0].length} ${LoanTextConstants.loan.toLowerCase()}${dictCateListWidget[0].length > 1 ? 's' : ''} ${LoanTextConstants.onGoing.toLowerCase()}',
                              style: const TextStyle(
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
                            ...dictCateListWidget[0].map((e) => LoanCard(
                                  loan: e,
                                  isAdmin: false,
                                  isDetail: false,
                                  onEdit: () {},
                                  onCalendar: () async {},
                                  onReturn: () async {},
                                  onInfo: () {
                                    loanNotifier.setLoan(e);
                                    pageNotifier.setLoanPage(
                                        LoanPage.detailLoanFromMain);
                                  },
                                )),
                            const SizedBox(width: 10),
                          ],
                        ),
                      )
                    ])
                  : (dictCateListWidget[1].isEmpty)
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: const [
                              Expanded(
                                child: Center(
                                    child: Text(LoanTextConstants.noLoan,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 205, 205, 205)))),
                              ),
                              Spacer()
                            ],
                          ),
                        )
                      : Container(),
              const SizedBox(height: 30),
              if (dictCateListWidget[1].isNotEmpty)
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          '${dictCateListWidget[1].length} ${LoanTextConstants.loan.toLowerCase()}${dictCateListWidget[1].length > 1 ? 's' : ''} ${LoanTextConstants.returned.toLowerCase()}${dictCateListWidget[1].length > 1 ? 's' : ''}',
                          style: const TextStyle(
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
                        ...dictCateListWidget[1]
                            .map((e) => LoanCard(
                                  loan: e,
                                  isAdmin: false,
                                  isDetail: false,
                                  onEdit: () {},
                                  onCalendar: () async {},
                                  onReturn: () async {},
                                  onInfo: () {
                                    loanNotifier.setLoan(e);
                                    pageNotifier.setLoanPage(
                                        LoanPage.detailLoanFromMain);
                                  },
                                ))
                            .toList(),
                        const SizedBox(width: 10),
                      ],
                    ),
                  )
                ])
            ])),
        if (isAdmin)
          Positioned(
            top: 0,
            right: 30,
            child: GestureDetector(
              onTap: () {
                pageNotifier.setLoanPage(LoanPage.admin);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                    HeroIcon(HeroIcons.userGroup, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Admin",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
          )
      ],
    );
  }
}
