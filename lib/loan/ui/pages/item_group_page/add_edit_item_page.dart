import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/item_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AddEditItemPage extends HookConsumerWidget {
  const AddEditItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final key = GlobalKey<FormState>();
    final loaner = ref.watch(loanerProvider);
    final isEdit = loaner.id != Loaner.empty().id;
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final item = ref.watch(itemProvider);
    final name = useTextEditingController(text: item.name);
    final caution =
        useTextEditingController(text: isEdit ? item.caution.toString() : '');
    final lendingDuration = useTextEditingController(
        text: isEdit
            ? (item.suggestedLendingDuration ~/ (24 * 60 * 60)).toString()
            : '');

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

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
                          ? LoanTextConstants.editItem
                          : LoanTextConstants.addObject,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 205, 205, 205)))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(children: [
                const SizedBox(height: 30),
                TextEntry(
                  keyboardType: TextInputType.text,
                  label: LoanTextConstants.name,
                  suffix: '',
                  isInt: false,
                  controller: name,
                ),
                const SizedBox(height: 30),
                TextEntry(
                  keyboardType: TextInputType.number,
                  controller: caution,
                  isInt: true,
                  label: LoanTextConstants.caution,
                  suffix: '€',
                ),
                const SizedBox(height: 30),
                TextEntry(
                  keyboardType: TextInputType.number,
                  controller: lendingDuration,
                  isInt: true,
                  label: LoanTextConstants.lendingDuration,
                  suffix: LoanTextConstants.days,
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    if (key.currentState == null) {
                      return;
                    }
                    if (key.currentState!.validate()) {
                      tokenExpireWrapper(ref, () async {
                        Item newItem = Item(
                            id: isEdit ? item.id : '',
                            name: name.text,
                            caution: int.parse(caution.text),
                            suggestedLendingDuration:
                                double.parse(lendingDuration.text) *
                                    24 *
                                    60 *
                                    60,
                            available: item.available);
                        final value = isEdit
                            ? await itemListNotifier.updateItem(
                                newItem, loaner.id)
                            : await itemListNotifier.addItem(
                                newItem, loaner.id);
                        if (value) {
                          pageNotifier.setLoanPage(LoanPage.admin);
                          loanersitemsNotifier.setTData(
                              loaner, await itemListNotifier.copy());
                          if (isEdit) {
                            displayToastWithContext(
                                TypeMsg.msg, LoanTextConstants.updatedItem);
                          } else {
                            displayToastWithContext(
                                TypeMsg.msg, LoanTextConstants.addedObject);
                          }
                        } else {
                          if (isEdit) {
                            displayToastWithContext(
                                TypeMsg.error, LoanTextConstants.updatingError);
                          } else {
                            displayToastWithContext(
                                TypeMsg.error, LoanTextConstants.addingError);
                          }
                        }
                      });
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
                      child: Text(
                          isEdit
                              ? LoanTextConstants.edit
                              : LoanTextConstants.add,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))),
                )
              ]),
            )
          ]),
        ));
  }
}
