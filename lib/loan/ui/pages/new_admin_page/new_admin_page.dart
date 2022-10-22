import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/new_admin_page/item_card.dart';
import 'package:myecl/loan/ui/pages/new_admin_page/loan_card.dart';
import 'package:myecl/loan/ui/pages/new_admin_page/loaner_chip.dart';
import 'package:myecl/loan/ui/refresh_indicator.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class NewAdminPage extends HookConsumerWidget {
  const NewAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanList = ref.watch(adminLoanListProvider);
    final loaner = ref.watch(loanerProvider);
    final loanListNotifier = ref.watch(adminLoanListProvider.notifier);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final loanersItems = ref.watch(loanersItemsProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loanerLoanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final loaded = useState(false);
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    if (!loaded.value) {
      ref.watch(userList);
      itemListNotifier.setId(loaner.id);
      itemListNotifier.loadItemList();
      itemListNotifier.copy().then(
        (value) {
          loanersitemsNotifier.setTData(loaner, value);
        },
      );
      loanerLoanListNotifier.loadLoan(loaner.id);
      loanerLoanListNotifier.copy().then(
        (value) {
          loanListNotifier.setTData(loaner, value);
        },
      );
      loaded.value = true;
    }
    return LoanRefresher(
      onRefresh: () async {
        itemListNotifier.setId(loaner.id);
        itemListNotifier.loadItemList();
        loanersitemsNotifier.setTData(loaner, await itemListNotifier.copy());
        loanerLoanListNotifier.loadLoan(loaner.id);
        loanListNotifier.setTData(loaner, await loanerLoanListNotifier.copy());
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(LoanTextConstants.admin,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
            loanList.when(
                data: (Map<Loaner, AsyncValue<List<Loan>>> loans) => Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 15),
                              ...loans
                                  .map((key, value) => MapEntry(
                                      LoanerChip(
                                        label: capitalize(key.name),
                                        selected: loaner.id == key.id,
                                        onTap: () async {
                                          itemListNotifier.setId(key.id);
                                          itemListNotifier.loadItemList();
                                          loanersitemsNotifier.setTData(key,
                                              await itemListNotifier.copy());
                                          loanerLoanListNotifier
                                              .loadLoan(loaner.id);
                                          loanListNotifier.setTData(
                                              loaner,
                                              await loanerLoanListNotifier
                                                  .copy());
                                        },
                                      ),
                                      value))
                                  .keys,
                              const SizedBox(width: 15),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Padding(
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
                        const SizedBox(height: 10),
                        if (loans[loaner] != null)
                          loans[loaner]!.when(
                              data: (List<Loan> data) => SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            pageNotifier
                                                .setLoanPage(LoanPage.addLoan);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              width: 140,
                                              height: 180,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade200
                                                        .withOpacity(0.5),
                                                    spreadRadius: 5,
                                                    blurRadius: 10,
                                                    offset: const Offset(3, 3),
                                                  ),
                                                  BoxShadow(
                                                    color: Colors.grey.shade200
                                                        .withOpacity(0.5),
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
                              }),
                        const SizedBox(height: 20),
                        const Padding(
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
                        const SizedBox(height: 10),
                        loanersItems.when(
                          data: (items) {
                            if (items[loaner] != null) {
                              return items[loaner]!.when(
                                data: (List<Item> data) =>
                                    SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          pageNotifier
                                              .setLoanPage(LoanPage.addItem);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          padding: const EdgeInsets.all(12.0),
                                          child: Container(
                                            width: 140,
                                            height: 160,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade200
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 10,
                                                  offset: const Offset(3, 3),
                                                ),
                                                BoxShadow(
                                                  color: Colors.grey.shade200
                                                      .withOpacity(0.5),
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
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ...data.map((e) => ItemCard(item: e)),
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
                                },
                              );
                            } else {
                              return const Center(
                                child: Text('No items'),
                              );
                            }
                          },
                          error: (Object error, StackTrace? stackTrace) {
                            return const Center(child: Text('Error'));
                          },
                          loading: () {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            ));
                          },
                        )
                      ],
                    ),
                error: (Object error, StackTrace? stackTrace) {
                  return Center(child: Text('Error $error'));
                },
                loading: () {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                }),
          ],
        ),
      ),
    );
  }
}
