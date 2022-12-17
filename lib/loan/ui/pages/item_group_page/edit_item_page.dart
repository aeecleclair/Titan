import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/item_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class EditItemPage extends HookConsumerWidget {
  const EditItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final key = GlobalKey<FormState>();
    final loaner = ref.watch(loanerProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final item = ref.watch(itemProvider);
    final name = useTextEditingController(text: item.name);
    final caution = useTextEditingController(text: item.caution.toString());
    final lendingDuration = useTextEditingController(
        text: (item.suggestedLendingDuration ~/ (24 * 60 * 60)).toString());

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
                  child: Text(LoanTextConstants.editItem,
                      style: TextStyle(
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
                        final value = await itemListNotifier.updateItem(
                            item.copyWith(
                                name: name.text,
                                caution: int.parse(caution.text),
                                suggestedLendingDuration:
                                    double.parse(lendingDuration.text) *
                                        24 *
                                        60 *
                                        60),
                            loaner.id);
                        if (value) {
                          pageNotifier.setLoanPage(LoanPage.admin);
                          displayToastWithContext(
                              TypeMsg.msg, LoanTextConstants.updatedItem);
                          loanersitemsNotifier.setTData(
                              loaner, await itemListNotifier.copy());
                        } else {
                          displayToastWithContext(
                              TypeMsg.error, LoanTextConstants.updatingError);
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
                      child: const Text(LoanTextConstants.edit,
                          style: TextStyle(
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
