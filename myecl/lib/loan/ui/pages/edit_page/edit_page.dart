import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/association_list_provider.dart';
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
    final key = GlobalKey<FormState>();
    final associations = ref.watch(associationListProvider);
    final fakeItems = ref.watch(itemListProvider);
    final selectedItems = ref.watch(editSelectedListProvider);
    final selectedItemsNotifier = ref.watch(editSelectedListProvider.notifier);
    final loanListNotifier = ref.watch(loanListProvider.notifier);
    final loan = ref.watch(loanProvider);
    final number = useTextEditingController();
    final note = useTextEditingController();

    Widget w = const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.orange),
      ),
    );

    loan.when(
      data: (l) {
        number.text = l.borrowerId.toString();
        note.text = l.notes;
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
                state: _currentStep.value >= 0
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
                state: _currentStep.value >= 1
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
                state: _currentStep.value >= 2
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
                        const Text("Emprunteur : "),
                        Text(number.text),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Note : "),
                        Text(note.text),
                      ],
                    ),
                  ],
                ),
                isActive: _currentStep.value >= 0,
                state: _currentStep.value >= 3
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
                                print(key.currentState!.validate());
                                  if (key.currentState == null) {
                                    return;
                                  }
                                  if (key.currentState!.validate()) {
                                    pageNotifier.setLoanPage(LoanPage.main);
                                    loanListNotifier
                                        .updateLoan(
                                      Loan(
                                        association: l.association,
                                        items: items
                                            .where((element) => selectedItems[
                                                items.indexOf(element)])
                                            .toList() as List<Item>,
                                        borrowerId: number.text,
                                        caution: false,
                                        end: DateTime.now().add(
                                          const Duration(days: 7),
                                        ),
                                        id: l.id,
                                        notes: note.text,
                                        start: DateTime.now(),
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
                              ? const Text('Ajouter')
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
