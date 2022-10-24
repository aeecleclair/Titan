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
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/pages/detail_page/delay_dialog.dart';
import 'package:myecl/loan/ui/pages/admin_page/item_card.dart';
import 'package:myecl/loan/ui/loan_card.dart';
import 'package:myecl/loan/ui/pages/admin_page/loaner_chip.dart';
import 'package:myecl/loan/ui/refresh_indicator.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminLoanList = ref.watch(adminLoanListProvider);
    final loaner = ref.watch(loanerProvider);
    final loanerIdNotifier = ref.watch(loanerIdProvider.notifier);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final loanersItems = ref.watch(loanersItemsProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loaded = useState(false);
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final adminLoanListNotifier = ref.watch(adminLoanListProvider.notifier);
    void displayLoanToastWithContext(TypeMsg type, String msg) {
      displayLoanToast(context, type, msg);
    }

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
    return LoanRefresher(
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(LoanTextConstants.admin,
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 30),
            adminLoanList.when(
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
                                          loanerIdNotifier.setId(key.id);
                                          itemListNotifier.setId(key.id);
                                          itemListNotifier.loadItemList();
                                          loanersitemsNotifier.setTData(key,
                                              await itemListNotifier.copy());
                                          loanListNotifier.loadLoan(loaner.id);
                                          adminLoanListNotifier.setTData(loaner,
                                              await loanListNotifier.copy());
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
                                              width: 120,
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
                                                  isAdmin: true,
                                                  onEdit: () {
                                                    loanNotifier
                                                        .setLoan(e)
                                                        .then((_) {
                                                      ref.watch(
                                                          itemListProvider);
                                                      pageNotifier.setLoanPage(
                                                          LoanPage.editLoan);
                                                    });
                                                  },
                                                  onCalendar: () {
                                                    showDialog<int>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return DelayDialog(
                                                            onYes: (i) async {
                                                              Loan newLoan = e.copyWith(
                                                                  end: e.end.add(
                                                                      Duration(
                                                                          days:
                                                                              i)));
                                                              await loanNotifier
                                                                  .setLoan(
                                                                      newLoan);
                                                              tokenExpireWrapper(
                                                                  ref,
                                                                  () async {
                                                                final value =
                                                                    await loanListNotifier
                                                                        .extendLoan(
                                                                            newLoan,
                                                                            i);
                                                                if (value) {
                                                                  await adminLoanListNotifier
                                                                      .setTData(
                                                                          loaner,
                                                                          await loanListNotifier
                                                                              .copy());
                                                                  displayLoanToastWithContext(
                                                                      TypeMsg
                                                                          .msg,
                                                                      LoanTextConstants
                                                                          .extendedLoan);
                                                                } else {
                                                                  displayLoanToastWithContext(
                                                                      TypeMsg
                                                                          .error,
                                                                      LoanTextConstants
                                                                          .extendingError);
                                                                }
                                                              });
                                                            },
                                                          );
                                                        });
                                                  },
                                                  onReturn: () async {
                                                    tokenExpireWrapper(ref,
                                                        () async {
                                                      final value =
                                                          await loanListNotifier
                                                              .returnLoan(e);
                                                      if (value) {
                                                        pageNotifier
                                                            .setLoanPage(
                                                                LoanPage.admin);
                                                        await adminLoanListNotifier
                                                            .setTData(
                                                                loaner,
                                                                await loanListNotifier
                                                                    .copy());
                                                        displayLoanToastWithContext(
                                                            TypeMsg.msg,
                                                            LoanTextConstants
                                                                .returnedLoan);
                                                      } else {
                                                        displayLoanToastWithContext(
                                                            TypeMsg.msg,
                                                            LoanTextConstants
                                                                .returningError);
                                                      }
                                                    });
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
                                            width: 120,
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
