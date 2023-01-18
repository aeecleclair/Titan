import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/add_edit_button.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/date_entry.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/item_bar.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/search_result.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/start_date_entry.dart';
import 'package:myecl/loan/ui/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddEditLoanPage extends HookConsumerWidget {
  const AddEditLoanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final loan = ref.watch(loanProvider);
    final isEdit = loan.id != Loan.empty().id;
    final borrower = useState(loan.borrower);
    final note = useTextEditingController(text: loan.notes);
    final start = useTextEditingController(
        text: isEdit ? processDate(loan.start) : processDate(DateTime.now()));
    final end =
        useTextEditingController(text: isEdit ? processDate(loan.end) : "");
    final caution = useTextEditingController(text: loan.caution);
    final usersNotifier = ref.watch(userList.notifier);
    final queryController =
        useTextEditingController(text: isEdit ? loan.borrower.getName() : "");

    final numberSelected = useState(loan.items.length);
    final initialDate = useState(isEdit ? loan.start : DateTime.now());

    void evaluateEnd(List<Item> selected) {
      end.text = processDate(DateTime.parse(processDateBack(start.text)).add(
          Duration(
              days: (selected.fold<double>(
                  double.infinity,
                  (previousValue, element) =>
                      previousValue > element.suggestedLendingDuration
                          ? element.suggestedLendingDuration
                          : previousValue)).toInt())));
    }

    print("AddEditLoanPage.build");
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      isEdit
                          ? LoanTextConstants.editLoan
                          : LoanTextConstants.addLoan,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 205, 205, 205)))),
            ),
            const SizedBox(height: 30),
            
            items.when(data: (itemList) {
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
                                if (selectedItems[itemList.indexOf(e)] ||
                                    isEdit) {
                                  selectedItemsNotifier
                                      .toggle(itemList.indexOf(e))
                                      .then(
                                    (value) {
                                      List<Item> selected = itemList
                                          .where((element) =>
                                              value[itemList.indexOf(element)])
                                          .toList();
                                      numberSelected.value = selected.length;
                                      if (numberSelected.value > 0) {
                                        caution.text =
                                            "${selected.fold<double>(0, (previousValue, element) => previousValue + element.caution).toStringAsFixed(2)}€";
                                        evaluateEnd(selected);
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
                TextFormField(
                  onChanged: (value) {
                    tokenExpireWrapper(ref, () async {
                      if (queryController.text.isNotEmpty) {
                        await usersNotifier.filterUsers(queryController.text);
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
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SearchResult(
                    borrower: borrower, queryController: queryController),
                const SizedBox(height: 30),
                StartDateEntry(
                    end: end,
                    start: start,
                    initialDate: initialDate,
                    evaluateEnd: evaluateEnd),
                const SizedBox(height: 30),
                DateEntry(
                  title: LoanTextConstants.endDate,
                  controller: end,
                  dateBefore: initialDate.value,
                  onSelect: () {},
                ),
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
                AddEditButton(
                  isEdit: isEdit,
                  borrower: borrower,
                  note: note,
                  start: start,
                  end: end,
                  caution: caution,
                  onAddEdit: (p0) async {
                    if (key.currentState == null) {
                      return;
                    }
                    if (key.currentState!.validate() &&
                        borrower.value.id.isNotEmpty) {
                      p0();
                    } else {
                      displayToast(context, TypeMsg.error,
                          LoanTextConstants.incorrectOrMissingFields);
                    }
                  },
                ),
                const SizedBox(height: 30),
              ]),
            ),
          ]),
        ));
  }
}
