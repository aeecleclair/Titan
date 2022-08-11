import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/association_list_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class AddItemPage extends HookConsumerWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final _currentStep = useState(0);
    final key = GlobalKey<FormState>();
    final asso = useState('Asso 1');
    final associations = ref.watch(associationListProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final name = useTextEditingController();
    final caution = useTextEditingController();

    Widget w = const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(LoanColorConstants.orange),
      ),
    );

    associations.when(
      data: (listAsso) {
        List<Step> steps = [
          Step(
            title: const Text('Association'),
            content: Theme(
              data: Theme.of(context).copyWith(
                primaryColor: LoanColorConstants.lightGrey,
                unselectedWidgetColor: LoanColorConstants.lightGrey,
              ),
              child: Column(
                  children: listAsso
                      .map(
                        (e) => RadioListTile(
                            title: Text(e,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            selected: asso.value == e,
                            value: e,
                            activeColor: LoanColorConstants.orange,
                            groupValue: asso.value,
                            onChanged: (s) {
                              asso.value = s.toString();
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
            title: const Text('Objet'),
            content: TextFormField(
              controller: name,
              decoration: const InputDecoration(
                labelText: 'Nom',
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please enter some text';
                } else if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            isActive: _currentStep.value >= 0,
            state: _currentStep.value >= 1
                ? StepState.complete
                : StepState.disabled,
          ),
          Step(
            title: const Text('Objet'),
            content: TextFormField(
              controller: caution,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Caution',
                suffix: Text('€'),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Please enter some text';
                } else if (value.isEmpty) {
                  return 'Please enter some text';
                } else if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                } else if (int.parse(value) < 0) {
                  return 'Please enter a positive number';
                }
                return null;
              },
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
                    Text(asso.value),
                  ],
                ),
                Row(
                  children: [
                    const Text("Nom : "),
                    Text(name.text),
                  ],
                ),
                Row(
                  children: [
                    const Text("Caution : "),
                    Text(caution.text),
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
          _currentStep.value < steps.length ? _currentStep.value += 1 : null;
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
                                pageNotifier.setLoanPage(LoanPage.main);
                                tokenExpireWrapper(ref, () {
                                  itemListNotifier
                                      .addItem(
                                    Item(
                                      name: name.text,
                                      caution: int.parse(caution.text),
                                      expiration: DateTime.now().add(
                                        const Duration(days: 30),
                                      ),
                                      groupId: '',
                                      id: '',
                                    ),
                                  )
                                      .then((value) {
                                    if (value) {
                                      displayToast(
                                          context, TypeMsg.msg, "Objet ajouté");
                                    } else {
                                      displayToast(context, TypeMsg.error,
                                          "Erreur lors de l'ajout");
                                    }
                                  });
                                });
                                _currentStep.value = 0;
                              } else {
                                displayToast(context, TypeMsg.error,
                                    "Des champs sont manquants ou incorrects");
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
        w = const Center(
          child: Text('Aucune associations trouvée'),
        );
      },
      loading: () {},
    );
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(), child: w);
  }
}
