import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/date_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddLoanPage extends HookConsumerWidget {
  const AddLoanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final adminLoanListNotifier = ref.watch(adminLoanListProvider.notifier);
    final _currentStep = useState(0);
    final key = GlobalKey<FormState>();
    final asso = useState(ref.watch(loanerProvider));
    final associations = ref.watch(loanerListProvider);
    final items = useState(ref.watch(itemListProvider));
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final users = useState(ref.watch(userList));
    final usersNotifier = ref.watch(userList.notifier);
    final selectedItems = ref.watch(selectedListProvider);
    final selectedItemsNotifier = ref.watch(selectedListProvider.notifier);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final loaner = ref.watch(loanerProvider);
    final start = useTextEditingController();
    final end = useTextEditingController();
    final note = useTextEditingController();
    final queryController = useTextEditingController();
    final caution = useTextEditingController();
    final focus = useState(false);
    final borrower = useState(SimpleUser.empty());

    Widget w = const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(LoanColorConstants.orange),
      ),
    );

    associations.when(
      data: (listAsso) {
        if (listAsso.isNotEmpty) {
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
                            onChanged: (s) async {
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
                  DateEntry(
                      title: LoanTextConstants.beginDate, controller: start),
                  DateEntry(title: LoanTextConstants.endDate, controller: end),
                ],
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 3
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(LoanTextConstants.borrower),
              content: users.value.when(data: (u) {
                return Column(children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      focus.value = true;
                      tokenExpireWrapper(ref, () async {
                        final value = await usersNotifier
                            .filterUsers(queryController.text);
                        users.value = value;
                      });
                    },
                    controller: queryController,
                    autofocus: focus.value,
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
              state: _currentStep.value >= 4
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(LoanTextConstants.note),
              content: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: LoanTextConstants.note),
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
              state: _currentStep.value >= 5
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(LoanTextConstants.caution),
              content: TextFormField(
                decoration:
                    const InputDecoration(labelText: LoanTextConstants.note),
                controller: caution,
                validator: (value) {
                  if (value == null) {
                    return LoanTextConstants.noValue;
                  }
                  return null;
                },
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 6
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
                      Text(asso.value.name),
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
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
                      const Text(LoanTextConstants.caution + " : "),
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
                                                  previousValue +
                                                  element.caution)
                                          .toString() +
                                      "€");
                        },
                        error: (error, s) {
                          return Text(error.toString());
                        },
                        loading: () {
                          return const Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                LoanColorConstants.orange),
                          ));
                        },
                      )
                    ],
                  ),
                ],
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 7
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
                                              await loanListNotifier.addLoan(
                                            Loan(
                                              loaner: loaner,
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
                                                                  element
                                                                      .caution)
                                                          .toString() +
                                                      "€",
                                              end: DateTime.parse(end.text),
                                              id: "",
                                              notes: note.text,
                                              start: DateTime.parse(start.text),
                                              returned: false,
                                            ),
                                          );
                                          if (value) {
                                            await adminLoanListNotifier
                                                .setTData(
                                                    loaner,
                                                    await loanListNotifier
                                                        .copy());
                                            pageNotifier.setLoanPage(
                                                LoanPage.adminLoan);
                                            displayLoanToast(
                                                context,
                                                TypeMsg.msg,
                                                LoanTextConstants.addedLoan);
                                          } else {
                                            displayLoanToast(
                                                context,
                                                TypeMsg.error,
                                                LoanTextConstants.addingError);
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
                                  displayLoanToast(
                                      context,
                                      TypeMsg.error,
                                      LoanTextConstants
                                          .incorrectOrMissingFields);
                                }
                              },
                        child: (isLastStep)
                            ? const Text(LoanTextConstants.add)
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
        } else {
          w = const Text(LoanTextConstants.noAssociationsFounded);
        }
      },
      error: (e, s) {
        w = Text(e.toString());
      },
      loading: () {},
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

  _selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 1, now.month, now.day));
    dateController.text = DateFormat('yyyy-MM-dd').format(picked ?? now);
  }
}
