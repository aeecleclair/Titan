import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/loan_focus_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/providers/start_provider.dart';
import 'package:myecl/loan/router.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/admin_page/loan_card.dart';
import 'package:myecl/loan/ui/pages/admin_page/delay_dialog.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/card_layout.dart';
import 'package:myecl/tools/ui/dialog.dart';
import 'package:myecl/tools/ui/horizontal_list_view.dart';
import 'package:myecl/tools/ui/loader.dart';
import 'package:qlevar_router/qlevar_router.dart';

class OnGoingLoan extends HookConsumerWidget {
  const OnGoingLoan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    final editingController = useTextEditingController();
    final focus = ref.watch(loanFocusProvider);
    final itemList = ref.watch(itemListProvider);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return adminLoanList.when(
        data: (loans) {
          if (loans[loaner] != null) {
            return loans[loaner]!.when(
                data: (List<Loan> data) {
                  if (data.isNotEmpty) {
                    data.sort((a, b) => a.end.compareTo(b.end));
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            onChanged: (value) {
                              tokenExpireWrapper(ref, () async {
                                if (editingController.text.isNotEmpty) {
                                  adminLoanListNotifier.setTData(
                                      loaner,
                                      await loanListNotifier
                                          .filterLoans(editingController.text));
                                } else {
                                  adminLoanListNotifier.setTData(
                                      loaner, loanList);
                                }
                              });
                            },
                            focusNode: focusNode,
                            controller: editingController,
                            cursorColor:
                                const Color.fromARGB(255, 149, 149, 149),
                            decoration: InputDecoration(
                                labelText:
                                    '${data.isEmpty ? LoanTextConstants.none : data.length} ${LoanTextConstants.loan.toLowerCase()}${data.length > 1 ? 's' : ''} ${LoanTextConstants.onGoing.toLowerCase()}',
                                labelStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 149, 149, 149)),
                                suffixIcon: const Icon(
                                  Icons.search,
                                  color: Color.fromARGB(255, 149, 149, 149),
                                  size: 30,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 149, 149, 149),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 170,
                        child: HorizontalListView(
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () async {
                                  await loanNotifier.setLoan(Loan.empty());
                                  ref.watch(itemListProvider);
                                  startNotifier
                                      .setStart(processDate(DateTime.now()));
                                  endNotifier.setEnd("");
                                  QR.to(LoanRouter.root +
                                      LoanRouter.admin +
                                      LoanRouter.addEditLoan);
                                  loanersItemsNotifier.setTData(
                                      loaner, itemList);
                                },
                                child: const CardLayout(
                                  width: 100,
                                  height: 170,
                                  child: Center(
                                      child: HeroIcon(
                                    HeroIcons.plus,
                                    size: 40.0,
                                    color: Colors.black,
                                  )),
                                ),
                              ),
                              ...data
                                  .map((e) => LoanCard(
                                        loan: e,
                                        isAdmin: true,
                                        onEdit: () async {
                                          await loanNotifier.setLoan(e);
                                          ref.watch(itemListProvider);
                                          startNotifier
                                              .setStart(processDate(e.start));
                                          endNotifier
                                              .setEnd(processDate(e.end));
                                          QR.to(LoanRouter.root +
                                              LoanRouter.admin +
                                              LoanRouter.addEditLoan);
                                        },
                                        onCalendar: () async {
                                          await showDialog<int>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return DelayDialog(
                                                  onYes: (i) async {
                                                    Loan newLoan = e.copyWith(
                                                        end: e.end.add(
                                                            Duration(days: i)));
                                                    await loanNotifier
                                                        .setLoan(newLoan);
                                                    tokenExpireWrapper(ref,
                                                        () async {
                                                      final value =
                                                          await loanListNotifier
                                                              .extendLoan(
                                                                  newLoan, i);
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
                                          await showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomDialogBox(
                                                      title: LoanTextConstants
                                                          .returnLoan,
                                                      descriptions:
                                                          LoanTextConstants
                                                              .returnLoanDescription,
                                                      onYes: () async {
                                                        await tokenExpireWrapper(
                                                            ref, () async {
                                                          final loanItemsId = e
                                                              .itemsQuantity
                                                              .map((e) => e
                                                                  .itemSimple
                                                                  .id)
                                                              .toList();
                                                          final updatedItems = loanersItems
                                                              .when<List<Item>>(
                                                                  data: (items) => items[loaner]!.when(
                                                                      data: (items) =>
                                                                          items,
                                                                      loading:
                                                                          () =>
                                                                              [],
                                                                      error: (_,
                                                                              __) =>
                                                                          []),
                                                                  loading: () =>
                                                                      [],
                                                                  error:
                                                                      (_, __) =>
                                                                          [])
                                                              .map(
                                                            (element) {
                                                              if (loanItemsId
                                                                  .contains(
                                                                      element
                                                                          .id)) {
                                                                return element
                                                                    .copyWith(); //TODO
                                                              }
                                                              return element;
                                                            },
                                                          ).toList();
                                                          final value =
                                                              await loanListNotifier
                                                                  .returnLoan(
                                                                      e);
                                                          if (value) {
                                                            QR.to(LoanRouter
                                                                    .root +
                                                                LoanRouter
                                                                    .admin);
                                                            await loanersItemsNotifier
                                                                .setTData(
                                                                    loaner,
                                                                    AsyncData(
                                                                        updatedItems));
                                                            await adminLoanListNotifier
                                                                .setTData(
                                                                    loaner,
                                                                    await loanListNotifier
                                                                        .copy());
                                                            displayToastWithContext(
                                                                TypeMsg.msg,
                                                                LoanTextConstants
                                                                    .returnedLoan);
                                                          } else {
                                                            displayToastWithContext(
                                                                TypeMsg.msg,
                                                                LoanTextConstants
                                                                    .returningError);
                                                          }
                                                        });
                                                      }));
                                        },
                                        onInfo: () {
                                          loanNotifier.setLoan(e);
                                          QR.to(LoanRouter.root +
                                              LoanRouter.admin +
                                              LoanRouter.detail);
                                        },
                                      ))
                                  .toList(),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                error: (Object error, StackTrace? stackTrace) =>
                    Center(child: Text('Error $error')),
                loading: () => const Loader());
          } else {
            return const Loader();
          }
        },
        error: (Object error, StackTrace stackTrace) =>
            Center(child: Text('Error $error')),
        loading: () => const Loader());
  }
}
