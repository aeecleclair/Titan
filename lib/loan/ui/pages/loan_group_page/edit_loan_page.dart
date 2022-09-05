import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/date_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class EditLoanPage extends HookConsumerWidget {
  const EditLoanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final adminLoanListNotifier = ref.watch(adminLoanListProvider.notifier);
    final _currentStep = useState(0);
    final asso = useState(ref.watch(loanerProvider));
    final key = GlobalKey<FormState>();
    final associations = ref.watch(loanerListProvider);
    final items = useState(ref.watch(itemListProvider));
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final selectedItems = ref.watch(editSelectedListProvider);
    final selectedItemsNotifier = ref.watch(editSelectedListProvider.notifier);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final loan = ref.watch(loanProvider);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final borrower = useState(loan.borrower);
    final note = useTextEditingController(text: loan.notes);
    final noteFocus = useState(false);
    final start =
        useTextEditingController(text: loan.start.toString().split(" ")[0]);
    final end =
        useTextEditingController(text: loan.end.toString().split(" ")[0]);
    final caution = useTextEditingController(text: loan.caution);
    final cautionFocus = useState(false);
    final users = useState(ref.watch(userList));
    final usersNotifier = ref.watch(userList.notifier);
    final queryController = useTextEditingController();
    final queryFocus = useState(false);

    Widget w = const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(LoanColorConstants.orange),
      ),
    );

    associations.when(
      data: (listAsso) {
        List<Step> steps = [
          Step(
            title: const Text(LoanTextConstants.association),
            content: Column(
                children: listAsso
                    .map(
                      (e) => RadioListTile(
                          title: Text(capitalize(e.name),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          selected: asso.value.name == e.name,
                          value: e.name,
                          activeColor: LoanColorConstants.orange,
                          groupValue: asso.value.name,
                          onChanged: (s) {
                            asso.value = e;
                            tokenExpireWrapper(ref, () async {
                              itemListNotifier.setId(e.id);
                              items.value =
                                  await itemListNotifier.loadItemList();
                            });
                          }),
                    )
                    .toList()),
            isActive: _currentStep.value >= 0,
            state: _currentStep.value >= 0
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(
            title: const Text(LoanTextConstants.objects),
            content: Column(
              children: items.value.when(data: (itemList) {
                return itemList
                    .map(
                      (e) => CheckboxListTile(
                        title: Text(e.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: e.available
                                  ? LoanColorConstants.darkGrey
                                  : Colors.grey.shade700,
                              decoration: e.available
                                  ? null
                                  : TextDecoration.lineThrough,
                            )),
                        value: selectedItems[itemList.indexOf(e)],
                        onChanged: (s) {
                          if (e.available) {
                            selectedItemsNotifier.toggle(itemList.indexOf(e));
                          }
                        },
                      ),
                    )
                    .toList();
              }, error: (error, s) {
                return [
                  Text(error.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                ];
              }, loading: () {
                return [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        LoanColorConstants.orange),
                  ),
                ];
              }),
            ),
            isActive: _currentStep.value >= 0,
            state: _currentStep.value >= 1
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(
            title: const Text(LoanTextConstants.dates),
            content: Column(
              children: [
                DateEntry(title: LoanTextConstants.beginDate, controller: start),
                DateEntry(title: LoanTextConstants.endDate, controller: end)
              ],
            ),
            isActive: _currentStep.value >= 0,
            state: _currentStep.value >= 2
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(
            title: const Text(LoanTextConstants.borrower),
            content: users.value.when(data: (u) {
              return Column(children: <Widget>[
                TextField(
                  onChanged: (value) {
                    queryFocus.value = true;
                    noteFocus.value = false;
                    cautionFocus.value = false;
                    tokenExpireWrapper(ref, () async {
                      final value =
                          await usersNotifier.filterUsers(queryController.text);
                      users.value = value;
                    });
                  },
                  controller: queryController,
                  autofocus: queryFocus.value,
                  decoration: const InputDecoration(
                      labelText: LoanTextConstants.looking,
                      hintText: LoanTextConstants.looking,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
                const SizedBox(
                  height: 10,
                ),
                ...u.map(
                  (e) => GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  e.getName(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: (borrower.value.id == e.id)
                                        ? FontWeight.bold
                                        : FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                      ),
                      onTap: () {
                        borrower.value = e;
                      }),
                )
              ]);
            }, error: (error, s) {
              return Text(error.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500));
            }, loading: () {
              return const CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(LoanColorConstants.orange),
              );
            }),
            isActive: _currentStep.value >= 0,
            state: _currentStep.value >= 3
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(
            title: const Text(LoanTextConstants.note),
            content: Column(
              children: <Widget>[
                TextFormField(
                  autofocus: noteFocus.value,
                  onChanged: (value) {
                    loanNotifier.setLoan(loan.copyWith(notes: value));
                    noteFocus.value = true;
                    cautionFocus.value = false;
                    queryFocus.value = false;
                  },
                  decoration:
                      const InputDecoration(labelText: LoanTextConstants.note),
                  controller: note,
                  validator: (value) {
                    if (value == null) {
                      return LoanTextConstants.noValue;
                    }
                    return null;
                  },
                ),
              ],
            ),
            isActive: _currentStep.value >= 0,
            state: _currentStep.value >= 4
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(
            title: const Text(LoanTextConstants.caution),
            content: TextFormField(
              autofocus: cautionFocus.value,
              onChanged: (value) {
                loanNotifier.setLoan(loan.copyWith(caution: value));
              },
              decoration:
                  const InputDecoration(labelText: LoanTextConstants.note),
              controller: caution,
            ),
            isActive: _currentStep.value >= 0,
            state: _currentStep.value >= 5
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(
            title: const Text(LoanTextConstants.confirmation),
            content: Column(
              children: <Widget>[
                Row(
                  children: [
                    const Text(LoanTextConstants.association + " : "),
                    Text(loan.loaner.name),
                  ],
                ),
                Row(
                  children: [
                    const Text(LoanTextConstants.borrower + " : "),
                    Text(borrower.value.getName()),
                  ],
                ),
                Column(
                  children: [
                    const Text(LoanTextConstants.objects + " : "),
                    ...items.value.when(
                      data: (itemList) {
                        return itemList
                            .where((element) =>
                                selectedItems[itemList.indexOf(element)])
                            .map(
                              (e) => Text(
                                e.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            )
                            .toList();
                      },
                      error: (error, s) {
                        return [Text(error.toString())];
                      },
                      loading: () {
                        return [
                          const Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                LoanColorConstants.orange),
                          ))
                        ];
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(LoanTextConstants.beginDate + " : "),
                    Text(start.text),
                  ],
                ),
                Row(
                  children: [
                    const Text(LoanTextConstants.endDate + " : "),
                    Text(end.text),
                  ],
                ),
                Row(
                  children: [
                    const Text(LoanTextConstants.note + " : "),
                    Text(note.text),
                  ],
                ),
                Row(
                  children: [
                    const Text(LoanTextConstants.paidCaution + " : "),
                    items.value.when(
                      data: (itemList) {
                        return Text(caution.text.isNotEmpty
                            ? caution.text
                            : caution.text.isNotEmpty
                                ? caution.text
                                : itemList
                                        .where((element) => selectedItems[
                                            itemList.indexOf(element)])
                                        .toList()
                                        .fold<double>(
                                            0,
                                            (previousValue, element) =>
                                                previousValue + element.caution)
                                        .toString() +
                                    "€");
                      },
                      error: (error, s) {
                        return Text(error.toString());
                      },
                      loading: () {
                        return const Center(
                            child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(LoanColorConstants.orange),
                        ));
                      },
                    )
                  ],
                ),
              ],
            ),
            isActive: _currentStep.value >= 0,
            state: _currentStep.value >= 6
                ? StepState.complete
                : StepState.disabled,
          ),
        ];

        void continued() {
          _currentStep.value < steps.length ? _currentStep.value += 1 : null;
        }

        void cancel() {
          _currentStep.value > 0 ? _currentStep.value -= 1 : null;
        }

        w = Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: key,
          child: Stepper(
            physics: const BouncingScrollPhysics(),
            currentStep: _currentStep.value,
            onStepTapped: (step) => _currentStep.value = step,
            onStepContinue: continued,
            onStepCancel: cancel,
            controlsBuilder: (context, ControlsDetails controls) {
              final isLastStep = _currentStep.value == steps.length - 1;
              return Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: !isLastStep
                          ? controls.onStepContinue
                          : () {
                              if (key.currentState == null) {
                                return;
                              }
                              if (key.currentState!.validate() &&
                                  borrower.value.id.isNotEmpty) {
                                if (start.text.compareTo(end.text) >= 0) {
                                  displayLoanToast(context, TypeMsg.error,
                                      LoanTextConstants.invalidDates);
                                } else {
                                  items.value.when(
                                    data: (itemList) {
                                      tokenExpireWrapper(ref, () async {
                                        List<Item> selected = itemList
                                            .where((element) => selectedItems[
                                                itemList.indexOf(element)])
                                            .toList();
                                        final value =
                                            await loanListNotifier.updateLoan(
                                          Loan(
                                            loaner: loan.loaner,
                                            items: selected,
                                            borrower: borrower.value,
                                            caution: caution.text.isNotEmpty
                                                ? caution.text
                                                : selected
                                                        .fold<double>(
                                                            0,
                                                            (previousValue,
                                                                    element) =>
                                                                previousValue +
                                                                element.caution)
                                                        .toString() +
                                                    "€",
                                            end: DateTime.parse(end.text),
                                            id: loan.id,
                                            notes: note.text,
                                            start: DateTime.parse(start.text),
                                            returned: loan.returned,
                                          ),
                                        );
                                        if (value) {
                                          await adminLoanListNotifier.setTData(
                                              asso.value,
                                              await loanListNotifier.copy());
                                          pageNotifier
                                              .setLoanPage(LoanPage.groupLoan);
                                          displayLoanToast(context, TypeMsg.msg,
                                              LoanTextConstants.updatedLoan);
                                        } else {
                                          displayLoanToast(
                                              context,
                                              TypeMsg.error,
                                              LoanTextConstants.updatingError);
                                        }
                                      });
                                    },
                                    error: (error, s) {
                                      displayLoanToast(context, TypeMsg.error,
                                          error.toString());
                                    },
                                    loading: () {
                                      displayLoanToast(context, TypeMsg.error,
                                          LoanTextConstants.addingError);
                                    },
                                  );
                                }
                              } else {
                                displayLoanToast(context, TypeMsg.error,
                                    LoanTextConstants.incorrectOrMissingFields);
                              }
                            },
                      child: (isLastStep)
                          ? const Text(LoanTextConstants.update)
                          : const Text(LoanTextConstants.next),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (_currentStep.value > 0)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controls.onStepCancel,
                        child: const Text(LoanTextConstants.previous),
                      ),
                    )
                ],
              );
            },
            steps: steps,
          ),
        );
      },
      error: (e, s) {
        w = Text(e.toString());
      },
      loading: () {
        w = const Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(LoanColorConstants.orange),
          ),
        );
      },
    );

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Theme(
            data: Theme.of(context).copyWith(
              primaryColor: LoanColorConstants.lightGrey,
              unselectedWidgetColor: LoanColorConstants.lightGrey,
            ),
            child: w));
  }
}

