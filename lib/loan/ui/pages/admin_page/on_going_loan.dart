import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/class/loan.dart';
import 'package:titan/loan/providers/admin_loan_list_provider.dart';
import 'package:titan/loan/providers/end_provider.dart';
import 'package:titan/loan/providers/loan_focus_provider.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/loan_provider.dart';
import 'package:titan/loan/providers/loaner_loan_list_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/loan/providers/loaners_items_provider.dart';
import 'package:titan/loan/providers/start_provider.dart';
import 'package:titan/loan/router.dart';
import 'package:titan/loan/ui/pages/admin_page/loan_card.dart';
import 'package:titan/loan/ui/pages/admin_page/delay_dialog.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/builders/async_child.dart';
import 'package:titan/tools/ui/layouts/card_layout.dart';
import 'package:titan/tools/ui/widgets/custom_dialog_box.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/widgets/loader.dart';
import 'package:titan/tools/ui/widgets/styled_search_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class OnGoingLoan extends HookConsumerWidget {
  const OnGoingLoan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    final loaner = ref.watch(loanerProvider);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final loanList = ref.watch(loanerLoanListProvider);
    final loanersItemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final loanersItems = ref.watch(loanersItemsProvider);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final adminLoanListNotifier = ref.watch(adminLoanListProvider.notifier);
    final adminLoanList = ref.watch(adminLoanListProvider);
    final startNotifier = ref.watch(startProvider.notifier);
    final endNotifier = ref.watch(endProvider.notifier);
    final focus = ref.watch(loanFocusProvider);
    final itemList = ref.watch(itemListProvider);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    if (adminLoanList[loaner] == null) {
      return const Loader();
    }
    return AsyncChild(
      value: adminLoanList[loaner]!,
      builder: (context, data) {
        if (data.isNotEmpty) {
          data.sort((a, b) => a.end.compareTo(b.end));
        }
        return Column(
          children: [
            StyledSearchBar(
              label:
                  '${data.isEmpty ? AppLocalizations.of(context)!.loanNone : data.length} ${AppLocalizations.of(context)!.loanLoan.toLowerCase()}${data.length > 1 ? 's' : ''} ${AppLocalizations.of(context)!.loanOnGoing.toLowerCase()}',
              onChanged: (value) async {
                if (value.isNotEmpty) {
                  adminLoanListNotifier.setTData(
                    loaner,
                    await loanListNotifier.filterLoans(value),
                  );
                } else {
                  adminLoanListNotifier.setTData(loaner, loanList);
                }
              },
            ),
            const SizedBox(height: 10),
            HorizontalListView.builder(
              height: 170,
              firstChild: GestureDetector(
                onTap: () async {
                  await loanNotifier.setLoan(Loan.empty());
                  startNotifier.setStart(
                    DateFormat.yMd(locale).format(DateTime.now()),
                  );
                  endNotifier.setEnd("");
                  QR.to(
                    LoanRouter.root + LoanRouter.admin + LoanRouter.addEditLoan,
                  );
                  loanersItemsNotifier.setTData(loaner, itemList);
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
              items: data,
              itemBuilder: (context, e, i) => LoanCard(
                loan: e,
                isAdmin: true,
                onEdit: () async {
                  await loanNotifier.setLoan(e);
                  startNotifier.setStart(
                    DateFormat.yMd(locale).format(e.start),
                  );
                  endNotifier.setEnd(DateFormat.yMd(locale).format(e.end));
                  QR.to(
                    LoanRouter.root + LoanRouter.admin + LoanRouter.addEditLoan,
                  );
                  loanersItemsNotifier.setTData(loaner, itemList);
                },
                onCalendar: () async {
                  final extendedLoanMsg = AppLocalizations.of(
                    context,
                  )!.loanExtendedLoan;
                  final extendedLoanErrorMsg = AppLocalizations.of(
                    context,
                  )!.loanExtendingError;
                  await showDialog<int>(
                    context: context,
                    builder: (BuildContext context) {
                      return DelayDialog(
                        onYes: (i) async {
                          Loan newLoan = e.copyWith(
                            end: e.end.add(Duration(days: i)),
                          );
                          await loanNotifier.setLoan(newLoan);
                          tokenExpireWrapper(ref, () async {
                            final value = await loanListNotifier.extendLoan(
                              newLoan,
                              i,
                            );
                            if (value) {
                              adminLoanListNotifier.setTData(
                                loaner,
                                await loanListNotifier.copy(),
                              );
                              displayToastWithContext(
                                TypeMsg.msg,
                                extendedLoanMsg,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                extendedLoanErrorMsg,
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
                      title: AppLocalizations.of(context)!.loanReturnLoan,
                      descriptions: AppLocalizations.of(
                        context,
                      )!.loanReturnLoanDescription,
                      onYes: () async {
                        final returningLoanMsg = AppLocalizations.of(
                          context,
                        )!.loanReturnedLoan;
                        final returningLoanErrorMsg = AppLocalizations.of(
                          context,
                        )!.loanReturningError;
                        await tokenExpireWrapper(ref, () async {
                          final loanItemsId = e.itemsQuantity
                              .map((e) => e.itemSimple.id)
                              .toList();
                          final updatedItems = loanersItems[loaner]!
                              .maybeWhen<List<Item>>(
                                data: (items) => items,
                                orElse: () => [],
                              )
                              .map((item) {
                                if (loanItemsId.contains(item.id)) {
                                  return item.copyWith();
                                }
                                return item;
                              })
                              .toList();
                          final value = await loanListNotifier.returnLoan(e);
                          if (value) {
                            QR.to(LoanRouter.root + LoanRouter.admin);
                            loanersItemsNotifier.setTData(
                              loaner,
                              AsyncData(updatedItems),
                            );
                            adminLoanListNotifier.setTData(
                              loaner,
                              await loanListNotifier.copy(),
                            );
                            displayToastWithContext(
                              TypeMsg.msg,
                              returningLoanMsg,
                            );
                          } else {
                            displayToastWithContext(
                              TypeMsg.msg,
                              returningLoanErrorMsg,
                            );
                          }
                        });
                      },
                    ),
                  );
                },
                onInfo: () {
                  loanNotifier.setLoan(e);
                  QR.to(LoanRouter.root + LoanRouter.admin + LoanRouter.detail);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
