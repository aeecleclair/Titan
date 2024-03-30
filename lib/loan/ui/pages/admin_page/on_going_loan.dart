import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/loan_focus_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loan_list_provider.dart';
import 'package:myecl/loan/providers/loaners_loans_map_provider.dart';
import 'package:myecl/loan/providers/selected_loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_map_provider.dart';
import 'package:myecl/loan/providers/start_provider.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/pages/admin_page/loan_card.dart';
import 'package:myecl/loan/ui/pages/admin_page/delay_dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/layouts/card_layout.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/widgets/styled_search_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class OnGoingLoan extends HookConsumerWidget {
  const OnGoingLoan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLoaner = ref.watch(selectedLoanerProvider);

    final loanListNotifier = ref.read(loanListProvider.notifier);

    final loanersItemsMapNotifier = ref.read(loanersItemsMapProvider.notifier);

    final loanersLoansMapNotifier = ref.watch(loanersLoansMapProvider.notifier);
    final selectedLoanerLoans =
        ref.watch(loanersLoansMapProvider.select((map) => map[selectedLoaner]));

    final loanNotifier = ref.watch(loanProvider.notifier);
    final startNotifier = ref.watch(startProvider.notifier);
    final endNotifier = ref.watch(endProvider.notifier);

    final ValueNotifier<String> filterQuery = useState("");

    final focus = ref.watch(loanFocusProvider);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return AutoLoaderChild(
      group: selectedLoanerLoans,
      notifier: loanersLoansMapNotifier,
      mapKey: selectedLoaner,
      listLoader: (loaner) async {
        return loanListNotifier.loadLoanList(loaner.id);
      },
      dataBuilder: (context, loans) {
        if (loans.isEmpty) {
          return const Center(
            child: Text(LoanTextConstants.noLoan),
          );
        }
        loans.sort((a, b) => a.end.compareTo(b.end));
        return Column(
          children: [
            StyledSearchBar(
              label:
                  '${loans.isEmpty ? LoanTextConstants.none : loans.length} ${LoanTextConstants.loan.toLowerCase()}${loans.length > 1 ? 's' : ''} ${LoanTextConstants.onGoing.toLowerCase()}',
              onChanged: (query) async {
                filterQuery.value = query;
              },
            ),
            const SizedBox(height: 10),
            HorizontalListView.builder(
              height: 170,
              firstChild: GestureDetector(
                onTap: () async {
                  await loanNotifier.setLoan(Loan.empty());
                  startNotifier.setStart(processDate(DateTime.now()));
                  endNotifier.setEnd("");
                  QR.to(
                    LoanRouter.root + LoanRouter.admin + LoanRouter.addEditLoan,
                  );
                },
                child: const CardLayout(
                  width: 100,
                  height: 170,
                  child: Center(
                    child: HeroIcon(
                      HeroIcons.plus,
                      size: 40.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              items: filteredLoans(loans, filterQuery.value),
              itemBuilder: (context, loan, _) => LoanCard(
                loan: loan,
                isAdmin: true,
                onEdit: () async {
                  await loanNotifier.setLoan(loan);
                  startNotifier.setStart(processDate(loan.start));
                  endNotifier.setEnd(processDate(loan.end));
                  QR.to(
                    LoanRouter.root + LoanRouter.admin + LoanRouter.addEditLoan,
                  );
                },
                onCalendar: () async {
                  await showDialog<int>(
                    context: context,
                    builder: (BuildContext context) {
                      return DelayDialog(
                        onYes: (i) async {
                          Loan newLoan = loan.copyWith(
                            end: loan.end.add(Duration(days: i)),
                          );
                          await loanNotifier.setLoan(newLoan);
                          tokenExpireWrapper(ref, () async {
                            final isLoandExtended =
                                await loanListNotifier.extendLoan(newLoan, i);
                            if (isLoandExtended) {
                              loanersLoansMapNotifier.updateLoanForLoaner(
                                selectedLoaner,
                                newLoan,
                              );
                              displayToastWithContext(
                                TypeMsg.msg,
                                LoanTextConstants.extendedLoan,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                LoanTextConstants.extendingError,
                              );
                            }
                          });
                        },
                      );
                    },
                  );
                },
                onReturn: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => CustomDialogBox(
                      title: LoanTextConstants.returnLoan,
                      descriptions: LoanTextConstants.returnLoanDescription,
                      onYes: () async {
                        await tokenExpireWrapper(ref, () async {
                          final isLoanReturned =
                              await loanListNotifier.returnLoan(loan);
                          if (isLoanReturned) {
                            QR.to(
                              LoanRouter.root + LoanRouter.admin,
                            );
                            loanersItemsMapNotifier
                                .updateItemsFromLoanReturnForLoaner(
                              selectedLoaner,
                              loan.itemsQuantity,
                            );
                            loanersLoansMapNotifier.removeLoanForLoaner(
                              selectedLoaner,
                              loan,
                            );
                            displayToastWithContext(
                              TypeMsg.msg,
                              LoanTextConstants.returnedLoan,
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.msg,
                              LoanTextConstants.returningError,
                            );
                          }
                        });
                      },
                    ),
                  );
                },
                onInfo: () {
                  loanNotifier.setLoan(loan);
                  QR.to(
                    LoanRouter.root + LoanRouter.admin + LoanRouter.detail,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
