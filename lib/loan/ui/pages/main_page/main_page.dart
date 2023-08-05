import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/is_loan_admin_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_list_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/loan.dart';
import 'package:myecl/loan/ui/pages/admin_page/loan_card.dart';
import 'package:myecl/tools/ui/widgets/admin_button.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tools/ui/layouts/refresher.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:qlevar_router/qlevar_router.dart';

class LoanMainPage extends HookConsumerWidget {
  const LoanMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanList = ref.watch(loanListProvider);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final loanListNotifier = ref.watch(loanListProvider.notifier);
    final isAdmin = ref.watch(isLoanAdminProvider);

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
          dictCateListWidget[0].sort((a, b) => b.end.compareTo(a.end));
          dictCateListWidget[1].sort((a, b) => b.end.compareTo(a.end));
        }
      },
      loading: () {},
      error: (error, s) {},
    );

    return LoanTemplate(
      child: Stack(
        children: [
          Refresher(
              onRefresh: () async {
                await loanListNotifier.loadLoanList();
              },
              child: Column(children: [
                const SizedBox(height: 40),
                (dictCateListWidget[0].isNotEmpty)
                    ? Column(children: [
                        AlignLeftText(
                          '${dictCateListWidget[0].length} ${LoanTextConstants.loan.toLowerCase()}${dictCateListWidget[0].length > 1 ? 's' : ''} ${LoanTextConstants.onGoing.toLowerCase()}',
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        HorizontalListView.builder(
                            height: 190,
                            items: dictCateListWidget[0],
                            itemBuilder: (context, e, i) => LoanCard(
                                  loan: e,
                                  onInfo: () {
                                    loanNotifier.setLoan(e);
                                    QR.to(LoanRouter.root + LoanRouter.detail);
                                  },
                                ))
                      ])
                    : (dictCateListWidget[1].isEmpty)
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Center(
                                      child: Text(LoanTextConstants.noLoan,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade300))),
                                ),
                                const Spacer()
                              ],
                            ),
                          )
                        : Container(),
                if (dictCateListWidget[1].isNotEmpty)
                  Column(children: [
                    const SizedBox(height: 30),
                    AlignLeftText(
                      '${dictCateListWidget[1].length} ${LoanTextConstants.loan.toLowerCase()}${dictCateListWidget[1].length > 1 ? 's' : ''} ${LoanTextConstants.returned.toLowerCase()}${dictCateListWidget[1].length > 1 ? 's' : ''}',
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    HorizontalListView.builder(
                        height: 190,
                        items: dictCateListWidget[1],
                        itemBuilder: (context, e, i) => LoanCard(
                              loan: e,
                              onInfo: () {
                                loanNotifier.setLoan(e);
                                QR.to(LoanRouter.root + LoanRouter.detail);
                              },
                            ))
                  ])
              ])),
          if (isAdmin)
            Positioned(
              top: 30,
              right: 30,
              child: AdminButton(
                onTap: () {
                  QR.to(LoanRouter.root + LoanRouter.admin);
                },
              ),
            )
        ],
      ),
    );
  }
}
