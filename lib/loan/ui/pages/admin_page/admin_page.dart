import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/admin_page/loaners_bar.dart';
import 'package:myecl/loan/ui/pages/admin_page/loaners_items.dart';
import 'package:myecl/loan/ui/pages/admin_page/on_going_loan.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/refresher.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loaner = ref.watch(loanerProvider);
    final loanerIdNotifier = ref.watch(loanerIdProvider.notifier);
    final adminLoanList = ref.watch(adminLoanListProvider);
    final loanersItems = ref.watch(loanersItemsProvider);

    final opened = useState(false);

    if (!opened.value) {
      final loaner = ref.read(loanerProvider);
      final itemListNotifier = ref.read(itemListProvider.notifier);
      itemListNotifier.loadItemList(loaner.id).then((value) {
        ref.read(loanersItemsProvider.notifier).setTData(loaner, value);
      });
      opened.value = true;
    }

    return Refresher(
      onRefresh: () async {
        final itemListNotifier = ref.read(itemListProvider.notifier);
        final loanersitemsNotifier = ref.read(loanersItemsProvider.notifier);
        final loanListNotifier = ref.read(loanerLoanListProvider.notifier);
        final adminLoanListNotifier = ref.read(adminLoanListProvider.notifier);
        itemListNotifier.loadItemList(loaner.id);
        loanersitemsNotifier.setTData(loaner, await itemListNotifier.copy());
        loanListNotifier.loadLoan(loaner.id);
        adminLoanListNotifier.setTData(loaner, await loanListNotifier.copy());
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            LoanersBar(onTap: (key) async {
              tokenExpireWrapper(ref, () async {
                loanerIdNotifier.setId(key.id);
                loanersItems.whenData(
                  (value) async {
                    final itemListNotifier =
                        ref.read(itemListProvider.notifier);
                    final loanersitemsNotifier =
                        ref.read(loanersItemsProvider.notifier);
                    if (value[key] != null) {
                      value[key]!.whenData((value) async {
                        if (value.isEmpty) {
                          final res =
                              await itemListNotifier.loadItemList(key.id);
                          await loanersitemsNotifier.setTData(key, res);
                        }
                      });
                    } else {
                      final res = await itemListNotifier.loadItemList(key.id);
                      await loanersitemsNotifier.setTData(key, res);
                    }
                  },
                );
                adminLoanList.whenData(
                  (value) async {
                    final loanListNotifier =
                        ref.read(loanerLoanListProvider.notifier);
                    final adminLoanListNotifier =
                        ref.read(adminLoanListProvider.notifier);
                    if (value[key] != null) {
                      value[key]!.whenData((value) async {
                        if (value.isEmpty) {
                          final res = await loanListNotifier.loadLoan(key.id);
                          adminLoanListNotifier.setTData(key, res);
                        }
                      });
                    } else {
                      final res = await loanListNotifier.loadLoan(key.id);
                      adminLoanListNotifier.setTData(key, res);
                    }
                  },
                );
              });
            }),
            Column(
              children: const [
                SizedBox(height: 40),
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
                            color: Color.fromARGB(255, 149, 149, 149))),
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
