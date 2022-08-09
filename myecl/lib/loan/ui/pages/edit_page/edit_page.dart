import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/association_list_provider.dart';
import 'package:myecl/loan/providers/association_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_list_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';

class EditPage extends HookConsumerWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final _currentStep = useState(0);
    final asso = ref.watch(associationFromLoanProvider);
    final assoNotifier = ref.watch(associationFromLoanProvider.notifier);
    final key = GlobalKey<FormState>();
    final associations = ref.watch(associationListProvider);
    final fakeItems = ref.watch(itemListProvider);
    final selectedItems = ref.watch(editSelectedListProvider);
    final selectedItemsNotifier = ref.watch(editSelectedListProvider.notifier);
    final loanListNotifier = ref.watch(loanListProvider.notifier);
    final loan = ref.watch(loanProvider);
    final loanNotifier = ref.watch(loanProvider.notifier);
    final number = useTextEditingController();
    final note = useTextEditingController();
    final start = useTextEditingController();
    final end = useTextEditingController();
    final caution = useState(false);

    Widget w = const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.orange),
      ),
    );

    loan.when(
      data: (l) {
        number.text = l.borrowerId.toString();
        note.text = l.notes;
        start.text = l.start.toString().split(" ")[0];
        end.text = l.end.toString().split(" ")[0];
        caution.value = l.caution;
        associations.when(
          data: (listAsso) {
            var items = [];
            fakeItems.when(
                data: (listItems) {
                  items = listItems;
                },
                error: (e, s) {},
                loading: () {});

            List<Step> steps = [
              Step(
                title: const Text('Association'),
                content: Theme(
                  data: Theme.of(context).copyWith(
                    primaryColor: ColorConstant.lightGrey,
                    unselectedWidgetColor: ColorConstant.lightGrey,
                  ),
                  child: Column(
                      children: listAsso
                          .map(
                            (e) => RadioListTile(
                                title: Text(e,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                selected: asso == e,
                                value: e,
                                activeColor: ColorConstant.orange,
                                groupValue: asso,
                                onChanged: (s) {
                                  assoNotifier.update(s.toString());
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
                title: const Text('Objets'),
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
                title: const Text('Dates'),
                content: Column(
                  children: [
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
                                "Date de la commande",
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
                                          color: Color.fromARGB(
                                              255, 158, 158, 158),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter a date for your task";
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
                                  "Date de la commande",
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
                                            color: Color.fromARGB(
                                                255, 158, 158, 158),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter a date for your task";
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
                title: const Text('Emprunteur'),
                content: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: number,
                      decoration:
                          const InputDecoration(labelText: 'Mobile Number'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter some text';
                        } else if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                isActive: _currentStep.value >= 0,
                state: _currentStep.value >= 3
                    ? StepState.complete
                    : StepState.disabled,
              ),
              Step(
                title: const Text('Note'),
                content: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Note'),
                      controller: note,
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter some text';
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
                title: const Text('Caution'),
                content: CheckboxListTile(
                  value: caution.value,
                  title: const Text('La caution est payée'),
                  onChanged: (value) {
                    loanNotifier.toggleCaution();
                    caution.value = !caution.value;
                  },
                ),
                isActive: _currentStep.value >= 0,
                state: _currentStep.value >= 5
                    ? StepState.complete
                    : StepState.disabled,
              ),
              Step(
                title: const Text('Confirmation'),
                content: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        const Text("Association : "),
                        Text(l.association),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Emprunteur : "),
                        Text(number.text),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Objets : "),
                        ...items
                            .where((element) =>
                                selectedItems[items.indexOf(element)])
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
                        const Text("Date de début : "),
                        Text(start.text),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Date de fin : "),
                        Text(end.text),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Note : "),
                        Text(note.text),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Caution payée : "),
                        Text(caution.value ? "Oui" : "Non"),
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
              _currentStep.value < steps.length
                  ? _currentStep.value += 1
                  : null;
            }

            void cancel() {
              _currentStep.value > 0 ? _currentStep.value -= 1 : null;
            }

            w = Form(
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
                                    pageNotifier.setLoanPage(LoanPage.option);
                                    loanListNotifier
                                        .updateLoan(
                                      Loan(
                                        association: asso,
                                        items: items
                                            .where((element) => selectedItems[
                                                items.indexOf(element)])
                                            .toList() as List<Item>,
                                        borrowerId: number.text,
                                        caution: caution.value,
                                        end: DateTime.parse(end.text),
                                        id: l.id,
                                        notes: note.text,
                                        start: DateTime.parse(start.text),
                                      ),
                                    )
                                        .then((value) {
                                      if (value) {
                                        displayToast(context, TypeMsg.msg,
                                            'Prêt modifié');
                                      } else {
                                        displayToast(context, TypeMsg.error,
                                            'Erreur lors de la modification du prêt');
                                      }
                                    });
                                    _currentStep.value = 0;
                                  }
                                },
                          child: (isLastStep)
                              ? const Text('Modifier')
                              : const Text('Suivant'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (_currentStep.value > 0)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controls.onStepCancel,
                            child: const Text('Précédent'),
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
                valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.orange),
              ),
            );
          },
        );
      },
      error: (e, s) {
        w = Text(e.toString());
      },
      loading: () {
        w = const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.orange),
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
