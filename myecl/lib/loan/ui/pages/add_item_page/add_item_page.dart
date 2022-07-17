import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';

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
    final fake_items = [
      Item(
        name: "Item 1",
        caution: 20,
        expiration: DateTime.now().add(Duration(days: 1)),
        groupId: '',
        id: '1',
      ),
      Item(
        name: "Item 2",
        caution: 20,
        expiration: DateTime.now().add(Duration(days: 1)),
        groupId: '',
        id: '1',
      ),
      Item(
        name: "Item 3",
        caution: 20,
        expiration: DateTime.now().add(Duration(days: 1)),
        groupId: '',
        id: '2',
      ),
      Item(
        name: "Item 4",
        caution: 20,
        expiration: DateTime.now().add(Duration(days: 1)),
        groupId: '',
        id: '3',
      ),
    ];

    List<Step> steps = [
      Step(
        title: const Text('Association'),
        content: Column(
            children: fake_asso
                .map((e) => Row(
                  children: [
                    Radio(
                        value: e,
                        groupValue: "groupValue",
                        onChanged: (s) {
                          asso.value = s.toString();
                          print(asso.value);
                        }),
                        Text(e)
                  ],
                ))
                .toList()),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Objets'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Home Address'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Postcode'),
            ),
          ],
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Emprunteur'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Mobile Number'),
            ),
          ],
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Confirmation'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Confirm Password'),
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
