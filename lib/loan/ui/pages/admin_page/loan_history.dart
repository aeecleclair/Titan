import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/admin_history_loan_list_provider.dart';
import 'package:myecl/loan/providers/history_loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loan_focus_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/admin_page/loan_card.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/builders/async_child.dart';
import 'package:myecl/tools/ui/layouts/horizontal_list_view.dart';
import 'package:myecl/tools/ui/widgets/loader.dart';

class HistoryLoan extends HookConsumerWidget {
  const HistoryLoan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
    final historyLoanListNotifier =
        ref.watch(historyLoanerLoanListProvider.notifier);
    final loanList = ref.watch(historyLoanerLoanListProvider);
    final adminHistoryLoanListNotifier =
        ref.watch(adminHistoryLoanListProvider.notifier);
    final adminLoanList = ref.watch(adminHistoryLoanListProvider);
    final editingController = useTextEditingController();
    final focus = ref.watch(loanFocusProvider);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    return AsyncChild(
        value: adminLoanList,
        builder: (context, loans) {
          if (loans[loaner] == null) {
            return const Loader();
          }
          return AsyncChild(
              value: loans[loaner]!,
              builder: (context, data) {
                if (data.isNotEmpty) {
                  data.sort((a, b) => b.end.compareTo(a.end));
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
                                adminHistoryLoanListNotifier.setTData(
                                    loaner,
                                    await historyLoanListNotifier
                                        .filterLoans(editingController.text));
                              } else {
                                adminHistoryLoanListNotifier.setTData(
                                    loaner, loanList);
                              }
                            });
                          },
                          focusNode: focusNode,
                          controller: editingController,
                          cursorColor: Colors.grey,
                          decoration: const InputDecoration(
                              labelText: LoanTextConstants.history,
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 30,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 110,
                      child: HorizontalListView(
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            ...data
                                .map((e) => LoanCard(loan: e, isHistory: true))
                                .toList(),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              });
        });
  }
}
