import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/admin_page/loaners_bar.dart';
import 'package:myecl/loan/ui/pages/admin_page/loaners_items.dart';
import 'package:myecl/loan/ui/pages/admin_page/on_going_loan.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loaded = useState(false);
    final adminLoanListNotifier = ref.watch(adminLoanListProvider.notifier);

    if (!loaded.value) {
      ref.watch(userList);
      itemListNotifier.setId(loaner.id);
      itemListNotifier.loadItemList();
      itemListNotifier.copy().then(
        (value) {
          loanersitemsNotifier.setTData(loaner, value);
        },
      );
      loanListNotifier.loadLoan(loaner.id);
      loanListNotifier.copy().then(
        (value) {
          adminLoanListNotifier.setTData(loaner, value);
        },
      );
      loaded.value = true;
    }
    return Refresher(
      onRefresh: () async {
        itemListNotifier.setId(loaner.id);
        itemListNotifier.loadItemList();
        loanersitemsNotifier.setTData(loaner, await itemListNotifier.copy());
        loanListNotifier.loadLoan(loaner.id);
        adminLoanListNotifier.setTData(loaner, await loanListNotifier.copy());
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const LoanersBar(),
            Column(
              children: const [
                SizedBox(height: 40),
                Padding(
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
                SizedBox(height: 15),
                OnGoingLoan(),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(LoanTextConstants.itemHandling,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 205, 205, 205))),
                  ),
                ),
                SizedBox(height: 15),
                LoanersItems(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
