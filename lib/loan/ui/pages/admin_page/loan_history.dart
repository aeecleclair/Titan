import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/admin_history_loan_list_provider.dart';
import 'package:myecl/loan/providers/history_loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loan_focus_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/ui/loan_card.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/web_list_view.dart';

class HistoryLoan extends HookConsumerWidget {
  const HistoryLoan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
    final historyloanListNotifier =
        ref.watch(historyLoanerLoanListProvider.notifier);
    final loanList = ref.watch(loanerLoanListProvider);
    final adminHistoryLoanListNotifier =
        ref.watch(adminHistoryLoanListProvider.notifier);
    final adminLoanList = ref.watch(adminHistoryLoanListProvider);
    final editingController = useTextEditingController();
    final focus = ref.watch(loanFocusProvider);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    return adminLoanList.when(data: (loans) {
      if (loans[loaner] != null) {
        return loans[loaner]!.when(data: (List<Loan> data) {
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
                          adminHistoryLoanListNotifier.setTData(
                              loaner,
                              await historyloanListNotifier
                                  .filterLoans(editingController.text));
                        } else {
                          adminHistoryLoanListNotifier.setTData(
                              loaner, loanList);
                        }
                      });
                    },
                    focusNode: focusNode,
                    controller: editingController,
                    cursorColor: const Color.fromARGB(255, 149, 149, 149),
                    decoration: const InputDecoration(
                        labelText: 'Historique',
                        labelStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 149, 149, 149)),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 149, 149, 149),
                          size: 30,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 149, 149, 149),
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 160,
                child: WebListView(
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      ...data
                          .map((e) => LoanCard(
                                loan: e,
                                isAdmin: false,
                                isDetail: false,
                                isHistory: true,
                                onEdit: () async {},
                                onCalendar: () async {},
                                onReturn: () async {},
                                onInfo: () {},
                              ))
                          .toList(),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              )
            ],
          );
        }, error: (Object error, StackTrace? stackTrace) {
          return Center(child: Text('Error $error'));
        }, loading: () {
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
