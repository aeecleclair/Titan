import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/loaner_chip.dart';
import 'package:myecl/loan/ui/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AddItemPage extends HookConsumerWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final key = GlobalKey<FormState>();
    final loaner = useState(ref.watch(loanerProvider));
    final loaners = ref.watch(loanerListProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final name = useTextEditingController();
    final caution = useTextEditingController();
    final lendingDuration = useTextEditingController();
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
                  child: Text(LoanTextConstants.addObject,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 205, 205, 205)))),
            ),
            const SizedBox(height: 30),
            loaners.when(
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
                              selected: loaner.value.id == e.id,
                              onTap: () async {
                                loaner.value = e;
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
                        final value = await itemListNotifier.addItem(
                          Item(
                            name: name.text,
                            caution: int.parse(caution.text),
                            id: '',
                            available: true,
                            suggestedLendingDuration:
                                int.parse(lendingDuration.text) * 24 * 60 * 60,
                          ),
                        );
                        if (value) {
                          pageNotifier.setLoanPage(LoanPage.admin);
                          await loanersitemsNotifier.setTData(
                              loaner.value, await itemListNotifier.copy());
                          displayToastWithContext(
                              TypeMsg.msg, LoanTextConstants.addedObject);
                        } else {
                          displayToastWithContext(
                              TypeMsg.error, LoanTextConstants.addingError);
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
                      child: const Text(LoanTextConstants.add,
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
