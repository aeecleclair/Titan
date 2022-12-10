import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/loaner_chip.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/search_result.dart';
import 'package:myecl/loan/ui/text_entry.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/check_item_card.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/date_entry.dart';
import 'package:myecl/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddLoanPage extends HookConsumerWidget {
  const AddLoanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final adminLoanListNotifier = ref.watch(adminLoanListProvider.notifier);
    final key = GlobalKey<FormState>();
    final asso = useState(ref.watch(loanerProvider));
    final associations = ref.watch(userLoanerListProvider);
    final items = useState(ref.watch(itemListProvider));
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final usersNotifier = ref.watch(userList.notifier);
    final selectedItems = ref.watch(selectedListProvider);
    final selectedItemsNotifier = ref.watch(selectedListProvider.notifier);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final start = useTextEditingController(text: processDate(DateTime.now()));
    final end = useTextEditingController();
    final note = useTextEditingController();
    final queryController = useTextEditingController();
    final caution = useTextEditingController();
    final borrower = useState(SimpleUser.empty());
    final numberSelected = useState(0);
    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
            key: key,
            child: Column(children: [
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(LoanTextConstants.addLoan,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 205, 205, 205)))),
              ),
              const SizedBox(height: 30),
              associations.when(
                  data: (data) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 15),
                            ...data.map(
                              (e) => LoanerChip(
                                label: capitalize(e.name),
                                selected: asso.value.id == e.id,
                                onTap: () async {
                                  asso.value = e;
                                  tokenExpireWrapper(ref, () async {
                                    itemListNotifier.setId(e.id);
                                    items.value =
                                        await itemListNotifier.loadItemList();
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                  error: (Object error, StackTrace? stackTrace) => Center(
                        child: Text("Error : $error"),
                      ),
                  loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      )),
              const SizedBox(height: 20),
              items.value.when(data: (itemList) {
                if (itemList.isNotEmpty) {
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 15),
                            ...itemList.map(
                              (e) => CheckItemCard(
                                item: e,
                                onCheck: () async {
                                  if (e.available) {
                                    selectedItemsNotifier
                                        .toggle(itemList.indexOf(e))
                                        .then(
                                      (value) {
                                        List<Item> selected = itemList
                                            .where((element) => value[
                                                itemList.indexOf(element)])
                                            .toList();
                                        numberSelected.value = selected.length;
                                        if (numberSelected.value > 0) {
                                          caution.text =
                                              "${selected.fold<double>(0, (previousValue, element) => previousValue + element.caution).toStringAsFixed(2)}€";
                                          end.text = processDate(DateTime.now()
                                              .add(Duration(
                                                  days: (selected.fold<double>(
                                                          double.infinity,
                                                          (previousValue,
                                                                  element) =>
                                                              previousValue >
                                                                      element
                                                                          .suggestedLendingDuration
                                                                  ? element
                                                                      .suggestedLendingDuration
                                                                  : previousValue) ~/
                                                      (24 * 60 * 60)))));
                                        } else {
                                          end.text = "";
                                          caution.text = "";
                                        }
                                      },
                                    );
                                  }
                                },
                                isSelected: selectedItems[itemList.indexOf(e)],
                              ),
                            ),
                            const SizedBox(width: 15),
                          ]));
                } else {
                  return const SizedBox(
                    height: 160,
                    child: Center(
                        child: Text(LoanTextConstants.noItems,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500))),
                  );
                }
              }, error: (error, s) {
                return SizedBox(
                  height: 160,
                  child: Text(error.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                );
              }, loading: () {
                return const SizedBox(
                  height: 160,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          ColorConstants.background2)),
                );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(children: [
                  const SizedBox(height: 20),
                  Text(
                    formatNumberItems(numberSelected.value),
                  ),
                  const SizedBox(height: 20),
                  Column(children: <Widget>[
                    TextFormField(
                      onChanged: (value) {
                        tokenExpireWrapper(ref, () async {
                          if (queryController.text.isNotEmpty) {
                            await usersNotifier
                                .filterUsers(queryController.text);
                          } else {
                            usersNotifier.clear();
                          }
                        });
                      },
                      cursorColor: Colors.black,
                      controller: queryController,
                      decoration: const InputDecoration(
                        labelText: LoanTextConstants.borrower,
                        floatingLabelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                      SearchResult(
                          borrower: borrower,
                          queryController: queryController),
                  ]),
                  const SizedBox(height: 30),
                  DateEntry(
                      title: LoanTextConstants.beginDate, controller: start),
                  const SizedBox(height: 30),
                  DateEntry(title: LoanTextConstants.endDate, controller: end),
                  const SizedBox(height: 30),
                  TextEntry(
                    keyboardType: TextInputType.text,
                    label: LoanTextConstants.note,
                    suffix: '',
                    isInt: false,
                    controller: note,
                  ),
                  const SizedBox(height: 30),
                  TextEntry(
                    keyboardType: TextInputType.text,
                    controller: caution,
                    isInt: false,
                    label: LoanTextConstants.caution,
                    suffix: '',
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      if (key.currentState == null) {
                        return;
                      }
                      if (key.currentState!.validate() &&
                          borrower.value.id.isNotEmpty) {
                        if (processDateBack(start.text)
                                .compareTo(processDateBack(end.text)) >=
                            0) {
                          displayToast(context, TypeMsg.error,
                              LoanTextConstants.invalidDates);
                        } else {
                          items.value.when(
                            data: (itemList) {
                              tokenExpireWrapper(ref, () async {
                                List<Item> selected = itemList
                                    .where((element) => selectedItems[
                                        itemList.indexOf(element)])
                                    .toList();
                                if (selected.isNotEmpty) {
                                  final value = await loanListNotifier.addLoan(
                                    Loan(
                                      loaner: asso.value,
                                      items: selected,
                                      borrower: borrower.value,
                                      caution: caution.text.isNotEmpty
                                          ? caution.text
                                          : "${selected.fold<double>(0, (previousValue, element) => previousValue + element.caution)}€",
                                      end: DateTime.parse(
                                          processDateBack(end.text)),
                                      id: "",
                                      notes: note.text,
                                      start: DateTime.parse(
                                          processDateBack(start.text)),
                                      returned: false,
                                    ),
                                  );
                                  if (value) {
                                    await adminLoanListNotifier.setTData(
                                        asso.value,
                                        await loanListNotifier.copy());
                                    pageNotifier.setLoanPage(LoanPage.admin);
                                    displayToastWithContext(TypeMsg.msg,
                                        LoanTextConstants.addedLoan);
                                  } else {
                                    displayToastWithContext(TypeMsg.error,
                                        LoanTextConstants.addingError);
                                  }
                                } else {
                                  displayToastWithContext(TypeMsg.error,
                                      LoanTextConstants.noItemSelected);
                                }
                              });
                            },
                            error: (error, s) {
                              displayToast(
                                  context, TypeMsg.error, error.toString());
                            },
                            loading: () {
                              displayToast(context, TypeMsg.error,
                                  LoanTextConstants.addingError);
                            },
                          );
                        }
                      } else {
                        displayToast(context, TypeMsg.error,
                            LoanTextConstants.incorrectOrMissingFields);
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8, bottom: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(
                                  3, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Text(LoanTextConstants.add,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(height: 30),
                ]),
              )
            ])));
  }
}
