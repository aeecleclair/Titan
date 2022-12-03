import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/loan_card.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/delay_dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class OnGoingLoan extends HookConsumerWidget {
  const OnGoingLoan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final adminLoanListNotifier = ref.watch(adminLoanListProvider.notifier);
    final adminLoanList = ref.watch(adminLoanListProvider);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return adminLoanList.when(data: (loans) {
      if (loans[loaner] != null) {
        return loans[loaner]!.when(
            data: (List<Loan> data) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          pageNotifier.setLoanPage(LoanPage.addLoan);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 120,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(3, 3),
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade200.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                            ),
                            child: const Center(
                                child: HeroIcon(
                              HeroIcons.plus,
                              size: 40.0,
                              color: Colors.black,
                            )),
                          ),
                        ),
                      ),
                      ...data
                          .map((e) => LoanCard(
                                loan: e,
                                isAdmin: true,
                                isDetail: false,
                                onEdit: () {
                                  loanNotifier.setLoan(e).then((_) {
                                    ref.watch(itemListProvider);
                                    pageNotifier.setLoanPage(LoanPage.editLoan);
                                  });
                                },
                                onCalendar: () {
                                  showDialog<int>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DelayDialog(
                                          onYes: (i) async {
                                            Loan newLoan = e.copyWith(
                                                end: e.end
                                                    .add(Duration(days: i)));
                                            await loanNotifier.setLoan(newLoan);
                                            tokenExpireWrapper(ref, () async {
                                              final value =
                                                  await loanListNotifier
                                                      .extendLoan(newLoan, i);
                                              if (value) {
                                                await adminLoanListNotifier
                                                    .setTData(
                                                        loaner,
                                                        await loanListNotifier
                                                            .copy());
                                                displayToastWithContext(
                                                    TypeMsg.msg,
                                                    LoanTextConstants
                                                        .extendedLoan);
                                              } else {
                                                displayToastWithContext(
                                                    TypeMsg.error,
                                                    LoanTextConstants
                                                        .extendingError);
                                              }
                                            });
                                          },
                                        );
                                      });
                                },
                                onReturn: () async {
                                  tokenExpireWrapper(ref, () async {
                                    final value =
                                        await loanListNotifier.returnLoan(e);
                                    if (value) {
                                      pageNotifier.setLoanPage(LoanPage.admin);
                                      await adminLoanListNotifier.setTData(
                                          loaner,
                                          await loanListNotifier.copy());
                                      displayToastWithContext(TypeMsg.msg,
                                          LoanTextConstants.returnedLoan);
                                    } else {
                                      displayToastWithContext(TypeMsg.msg,
                                          LoanTextConstants.returningError);
                                    }
                                  });
                                },
                                onInfo: () {
                                  loanNotifier.setLoan(e);
                                  pageNotifier.setLoanPage(
                                      LoanPage.detailLoanFromAdmin);
                                },
                              ))
                          .toList(),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
            error: (Object error, StackTrace? stackTrace) {
              return Center(child: Text('Error $error'));
            },
            loading: () {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            });
      } else {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      }
    }, error: (Object error, StackTrace stackTrace) {
      return Center(child: Text('Error $error'));
    }, loading: () {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
      ));
    });
  }
}
