import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class EditLoanPage extends HookConsumerWidget {
  const EditLoanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final _currentStep = useState(0);
    final asso = useState(ref.watch(loanerProvider));
    final key = GlobalKey<FormState>();
    final associations = ref.watch(loanerListProvider);
    final fakeItems = ref.watch(itemListProvider);
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
        List<Item> items = [];
        fakeItems.when(
            data: (listItems) {
              items = listItems;
            },
            error: (e, s) {},
            loading: () {});

        List<Step> steps = [
          Step(
            title: const Text(LoanTextConstants.association),
            content: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: LoanColorConstants.lightGrey,
                unselectedWidgetColor: LoanColorConstants.lightGrey,
              ),
              child: Column(
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
                            }),
                      )
                      .toList()),
            ),
            isActive: _currentStep.value >= 0,
            state: _currentStep.value >= 0
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(
            title: const Text(LoanTextConstants.objects),
            content: Column(
              children: items
                  .map(
                    (e) => CheckboxListTile(
                      title: Text(e.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      value: selectedItems[items.indexOf(e)],
                      onChanged: (s) {
                        selectedItemsNotifier.toggle(items.indexOf(e));
                      },
                    ),
                  )
                  .toList(),
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
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 3),
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text(
                            LoanTextConstants.beginDate,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 85, 85, 85),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _selectDate(context, start),
                          child: SizedBox(
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: start,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  isDense: true,
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 85, 85, 85))),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red)),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 158, 158, 158),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LoanTextConstants.enterDate;
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(bottom: 3),
                            padding: const EdgeInsets.only(left: 10),
                            child: const Text(
                              LoanTextConstants.endDate,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 85, 85, 85),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _selectDate(context, end),
                            child: SizedBox(
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: end,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    isDense: true,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 85, 85, 85))),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                    errorBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 158, 158, 158),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return LoanTextConstants.enterDate;
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ])),
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
                    ...items
                        .where(
                            (element) => selectedItems[items.indexOf(element)])
                        .map(
                          (e) => Text(
                            e.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        )
                        .toList(),
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
                    Text(caution.text.isEmpty
                        ? items
                                .fold<int>(
                                    0,
                                    (previousValue, element) =>
                                        previousValue + element.caution)
                                .toString() +
                            "€"
                        : caution.text),
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
                              if (key.currentState!.validate()) {
                                tokenExpireWrapper(ref, () async {
                                  final value = await loanListNotifier
                                      .updateLoan(
                                    Loan(
                                      loaner: loan.loaner,
                                      items: items
                                          .where((element) => selectedItems[
                                              items.indexOf(element)])
                                          .toList(),
                                      borrower: borrower.value,
                                      caution: caution.text.isEmpty
                                          ? items
                                              .fold<int>(
                                                  0,
                                                  (previousValue, element) =>
                                                      previousValue +
                                                      element.caution)
                                              .toString()
                                          : caution.text,
                                      end: DateTime.parse(end.text),
                                      id: loan.id,
                                      notes: note.text,
                                      start: DateTime.parse(start.text),
                                      returned: loan.returned,
                                    ),
                                  );
                                    if (value) {
                                      // displayLoanToast(context, TypeMsg.msg,
                                      //     LoanTextConstants.updatedLoan);
                                    } else {
                                      // displayLoanToast(context, TypeMsg.error,
                                      //     LoanTextConstants.updatingError);
                                    }
                                    pageNotifier
                                        .setLoanPage(LoanPage.adminLoan);
                                });
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
        physics: const BouncingScrollPhysics(), child: w);
  }
}

_selectDate(BuildContext context, TextEditingController dateController) async {
  final DateTime now = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, now.month, now.day));
  dateController.text = DateFormat('yyyy-MM-dd').format(picked ?? now);
}
