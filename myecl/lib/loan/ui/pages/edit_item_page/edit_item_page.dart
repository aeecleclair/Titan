import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/item_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class EditItemPage extends HookConsumerWidget {
  const EditItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final _currentStep = useState(0);
    final key = GlobalKey<FormState>();
    final loaner = useState(ref.watch(loanerProvider));
    final loaners = ref.watch(loanerListProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final item = ref.watch(itemProvider);
    final itemNotifier = ref.watch(itemProvider.notifier);
    final name = useTextEditingController(text: item.name);
    final nameFocus = useState(false);
    final caution = useTextEditingController(text: item.caution.toString());
    final cautionFocus = useState(false);
    final lendingDuration = useTextEditingController(
        text: item.suggestedLendingDuration.toInt().toString());
    final lendingDurationFocus = useState(false);

    Widget w = const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(LoanColorConstants.orange),
      ),
    );

    loaners.when(
      data: (listAsso) {
        if (listAsso.isNotEmpty) {
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              selected: loaner.value.name == e.name,
                              value: e.name,
                              activeColor: LoanColorConstants.orange,
                              groupValue: loaner.value.name,
                              onChanged: (s) {
                                loaner.value = e;
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
              content: TextFormField(
                onChanged: (n) {
                  itemNotifier.setItem(item.copyWith(name: n));
                  nameFocus.value = true;
                  cautionFocus.value = false;
                  lendingDurationFocus.value = false;
                },
                autofocus: nameFocus.value,
                controller: name,
                decoration: const InputDecoration(
                  labelText: LoanTextConstants.name,
                ),
                validator: (value) {
                  if (value == null) {
                    return LoanTextConstants.noValue;
                  } else if (value.isEmpty) {
                    return LoanTextConstants.noValue;
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
              title: const Text(LoanTextConstants.caution),
              content: TextFormField(
                onChanged: (d) {
                  itemNotifier.setItem(item.copyWith(caution: int.parse(d)));
                  cautionFocus.value = true;
                  lendingDurationFocus.value = false;
                  nameFocus.value = false;
                },
                autofocus: cautionFocus.value,
                controller: caution,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: LoanTextConstants.caution,
                  suffix: Text('€'),
                ),
                validator: (value) {
                  if (value == null) {
                    return LoanTextConstants.noValue;
                  } else if (value.isEmpty) {
                    return LoanTextConstants.noValue;
                  } else if (int.tryParse(value) == null) {
                    return LoanTextConstants.invalidNumber;
                  } else if (int.parse(value) < 0) {
                    return LoanTextConstants.positiveNumber;
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
              title: const Text(LoanTextConstants.lendingDuration),
              content: TextFormField(
                onChanged: (d) {
                  itemNotifier.setItem(
                      item.copyWith(suggestedLendingDuration: double.parse(d)));
                  cautionFocus.value = false;
                  lendingDurationFocus.value = true;
                  nameFocus.value = false;
                },
                autofocus: lendingDurationFocus.value,
                controller: lendingDuration,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: LoanTextConstants.lendingDuration,
                  suffix: Text('Jours'),
                ),
                validator: (value) {
                  if (value == null) {
                    return LoanTextConstants.noValue;
                  } else if (value.isEmpty) {
                    return LoanTextConstants.noValue;
                  } else if (int.tryParse(value) == null) {
                    return LoanTextConstants.invalidNumber;
                  } else if (int.parse(value) < 0) {
                    return LoanTextConstants.positiveNumber;
                  }
                  return null;
                },
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 3
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
                      Text(loaner.value.name),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(LoanTextConstants.name + " : "),
                      Text(item.name),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(LoanTextConstants.caution + " : "),
                      Text(item.caution.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(LoanTextConstants.lendingDuration + " : "),
                      Text(item.suggestedLendingDuration.toInt().toString()),
                    ],
                  ),
                ],
              ),
              isActive: _currentStep.value >= 0,
              state: _currentStep.value >= 4
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
            // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  pageNotifier.setLoanPage(LoanPage.adminItem);
                                  tokenExpireWrapper(ref, () async {
                                    itemListNotifier
                                        .updateItem(item)
                                        .then((value) async {
                                      if (value) {
                                        // displayLoanToast(context, TypeMsg.msg,
                                        //     LoanTextConstants.addedObject);
                                        loanersitemsNotifier.setLoanerItems(
                                            loaner.value,
                                            await itemListNotifier.copy());
                                      } else {
                                        // displayLoanToast(context, TypeMsg.error,
                                        //     LoanTextConstants.addingError);
                                      }
                                    });
                                  });
                                  _currentStep.value = 0;
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
          w = const Center(
            child: Text(LoanTextConstants.noAssociationsFounded),
          );
        }
      },
      error: (e, s) {
        w = Center(
          child: Text(e.toString()),
        );
      },
      loading: () {},
    );
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(), child: w);
  }
}
