import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loan_history_provider.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/loan_ui.dart';
import 'package:myecl/loan/ui/refresh_indicator.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class HistoryPage extends HookConsumerWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanHistory = ref.watch(loanHistoryProvider);
    final loanHistoryNotifier = ref.watch(loanHistoryProvider.notifier);
    final loaners = ref.watch(loanerList);
    final loanerLoanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    List<Widget> listWidget = [
      Container(
        margin: const EdgeInsets.only(right: 10, left: 20),
        height: 48,
        alignment: Alignment.centerLeft,
        child: const Text(
          LoanTextConstants.history,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      )
    ];

    loanHistory.when(
      data: (loaners) {
        if (loaners.isNotEmpty) {
          List<String> categories =
              (loaners.keys.toList()).map((e) => e.name).toList();
          Map<String, List<Widget>> dictCateListWidget = {
            for (var item in categories) item: []
          };
          for (Loaner l in loaners.keys) {
            if (loaners[l]!.item2) {
              loaners[l]?.item1.when(
                    data: (items) {
                      if (items.isNotEmpty) {
                        for (Loan i in items) {
                          dictCateListWidget[l.name]!.add(
                            LoanUi(l: i, isHistory: true, isAdmin: false),
                          );
                        }
                      } else {
                        dictCateListWidget[l.name]!.add(
                          Container(
                            height: 55,
                            alignment: Alignment.centerLeft,
                            child: const Center(
                              child: Text(
                                LoanTextConstants.noAvailableItems,
                                style: TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    error: (error, stackTrace) {},
                    loading: () {},
                  );
            }
          }

          for (Loaner l in loaners.keys) {
            listWidget.add(GestureDetector(
                child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            capitalize(l.name),
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        loaners[l]!.item1.when(
                          data: (items) {
                            return Container(
                                padding: const EdgeInsets.only(right: 20),
                                child: !loaners[l]!.item2
                                    ? const HeroIcon(
                                        HeroIcons.chevronUp,
                                      )
                                    : const HeroIcon(
                                        HeroIcons.chevronDown,
                                      ));
                          },
                          error: (error, stackTrace) {
                            return Container(
                                padding: const EdgeInsets.only(right: 20),
                                child: !loaners[l]!.item2
                                    ? const HeroIcon(
                                        HeroIcons.chevronUp,
                                      )
                                    : const HeroIcon(
                                        HeroIcons.chevronDown,
                                      ));
                          },
                          loading: () {
                            return Container(
                                padding: const EdgeInsets.only(right: 20),
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    LoanColorConstants.darkGrey,
                                  ),
                                ));
                          },
                        ),
                      ],
                    )),
                onTap: () async {
                  tokenExpireWrapper(ref, () async {
                    var loaded = await loanHistoryNotifier.toggleExpanded(l);
                    if (!loaded) {
                      loanerLoanListNotifier.loadHistory(l.id).then((value) {
                        loanHistoryNotifier.setLoanerItems(l, value);
                      });
                    }
                  });
                }));

            listWidget += dictCateListWidget[l.name] ?? [];
          }
        } else {
          listWidget.add(Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: Container(
              height: 40,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                LoanTextConstants.noLoan,
              ),
            ),
          ));
        }
      },
      loading: () {
        listWidget.add(const Center(
            child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(LoanColorConstants.darkGrey),
        )));
      },
      error: (error, s) {
        listWidget.add(Center(child: Text(error.toString())));
      },
    );

    return LoanRefresher(
      onRefresh: () async {
        loanHistoryNotifier.loadLoanerList(loaners);
      },
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
