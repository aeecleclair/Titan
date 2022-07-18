import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';

class AddItemPage extends HookConsumerWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final _currentStep = useState(0);
    final key = GlobalKey<FormState>();
    final asso = useState('Asso 1');
    final fake_asso = [
      "Asso 1",
      "Asso 2",
      "Asso 3",
    ];
    final name = useTextEditingController();
    final caution = useTextEditingController();

    List<Step> steps = [
      Step(
        title: const Text('Association'),
        content: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: ColorConstant.lightGrey,
            unselectedWidgetColor: ColorConstant.lightGrey,
          ),
          child: Column(
              children: fake_asso
                  .map(
                    (e) => RadioListTile(
                        title: Text(e,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        selected: asso.value == e,
                        value: e,
                        activeColor: ColorConstant.orange,
                        groupValue: asso.value,
                        onChanged: (s) {
                          asso.value = s.toString();
                          print(asso.value);
                        }),
                  )
                  .toList()),
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Objet'),
        content: Column(children: [
          TextFormField(
            controller: name,
            decoration: const InputDecoration(
              labelText: 'Nom',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: caution,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Caution',
              suffix: Text('€'),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ]),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Confirmation'),
        content: Column(
          children: <Widget>[
            Row(
              children: [
                Text("Association : "),
                Text(asso.value),
              ],
            ),
            Row(
              children: [
                Text("Nom : "),
                Text(name.text),
              ],
            ),
            Row(
              children: [
                Text("Caution : "),
                Text(caution.text),
              ],
            ),
          ],
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 2 ? StepState.complete : StepState.disabled,
      ),
    ];

    void continued() {
      _currentStep.value < steps.length ? _currentStep.value += 1 : null;
    }

    void cancel() {
      _currentStep.value > 0 ? _currentStep.value -= 1 : null;
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Form(
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
                              print("validated");
                              pageNotifier.setLoanPage(LoanPage.main);
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
      ),
    );
  }
}
