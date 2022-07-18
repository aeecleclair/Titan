import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';

class AddLoanPage extends HookConsumerWidget {
  const AddLoanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final _currentStep = useState(0);
    final key = GlobalKey<FormState>();
    final asso = useState('Asso 1');
    final fakeAsso = [
      "Asso 1",
      "Asso 2",
      "Asso 3",
    ];
    final fakeItems = [
      Item(
        name: "Item 1",
        caution: 20,
        expiration: DateTime.now().add(const Duration(days: 1)),
        groupId: '',
        id: '1',
      ),
      Item(
        name: "Item 2",
        caution: 20,
        expiration: DateTime.now().add(const Duration(days: 1)),
        groupId: '',
        id: '1',
      ),
      Item(
        name: "Item 3",
        caution: 20,
        expiration: DateTime.now().add(const Duration(days: 1)),
        groupId: '',
        id: '2',
      ),
      Item(
        name: "Item 4",
        caution: 20,
        expiration: DateTime.now().add(const Duration(days: 1)),
        groupId: '',
        id: '3',
      ),
    ];
    final selectedItems = ref.watch(selectedListProvider);
    final selectedItemsNotifier = ref.watch(selectedListProvider.notifier);
    final number = useTextEditingController();

    List<Step> steps = [
      Step(
        title: const Text('Association'),
        content: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: ColorConstant.lightGrey,
            unselectedWidgetColor: ColorConstant.lightGrey,
          ),
          child: Column(
              children: fakeAsso
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
                        }),
                  )
                  .toList()),
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Objets'),
        content: Column(
          children: fakeItems
              .map(
                (e) => CheckboxListTile(
                  title: Text(e.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                  value: selectedItems[fakeItems.indexOf(e)],
                  onChanged: (s) {
                    selectedItemsNotifier.toggle(fakeItems.indexOf(e));
                  },
                ),
              )
              .toList(),
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
              controller: number,
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
            Row(
              children: [
                const Text("Association : "),
                Text(asso.value),
              ],
            ),
            Column(
              children: [
                const Text("Objets : "),
                ...fakeItems
                    .where(
                        (element) => selectedItems[fakeItems.indexOf(element)])
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
          ],
        ),
        isActive: _currentStep.value >= 0,
        state:
            _currentStep.value >= 3 ? StepState.complete : StepState.disabled,
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
