import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loaners_items_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class AddItemPage extends HookConsumerWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final currentStep = useState(0);
    final key = GlobalKey<FormState>();
    final loaner = useState(ref.watch(loanerProvider));
    final loaners = ref.watch(loanerListProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loanersitemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final name = useTextEditingController();
    final caution = useTextEditingController();
    final lendingDuration = useTextEditingController();

    void displayLoanToastWithContext(TypeMsg type, String msg) {
      displayLoanToast(context, type, msg);
    }

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
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 0
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(LoanTextConstants.objects),
              content: TextFormField(
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
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 1
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(LoanTextConstants.caution),
              content: TextFormField(
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
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 2
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(LoanTextConstants.lendingDuration),
              content: TextFormField(
                controller: lendingDuration,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: LoanTextConstants.lendingDuration,
                  suffix: Text(LoanTextConstants.days),
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
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 3
                  ? StepState.complete
                  : StepState.disabled,
            ),
            Step(
              title: const Text(LoanTextConstants.confirmation),
              content: Column(
                children: <Widget>[
                  Row(
                    children: [
                      const Text("${LoanTextConstants.association} : "),
                      Text(loaner.value.name),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("${LoanTextConstants.name} : "),
                      Text(name.text),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("${LoanTextConstants.caution} : "),
                      Text(caution.text),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("${LoanTextConstants.lendingDuration} : "),
                      Text(lendingDuration.text),
                    ],
                  ),
                ],
              ),
              isActive: currentStep.value >= 0,
              state: currentStep.value >= 4
                  ? StepState.complete
                  : StepState.disabled,
            ),
          ];

          void continued() {
            currentStep.value < steps.length ? currentStep.value += 1 : null;
          }

          void cancel() {
            currentStep.value > 0 ? currentStep.value -= 1 : null;
          }

          w = Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: key,
            child: Stepper(
              physics: const BouncingScrollPhysics(),
              currentStep: currentStep.value,
              onStepTapped: (step) => currentStep.value = step,
              onStepContinue: continued,
              onStepCancel: cancel,
              controlsBuilder: (context, ControlsDetails controls) {
                final isLastStep = currentStep.value == steps.length - 1;
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
                                    final value =
                                        await itemListNotifier.addItem(
                                      Item(
                                        name: name.text,
                                        caution: int.parse(caution.text),
                                        id: '',
                                        available: true,
                                        suggestedLendingDuration:
                                            int.parse(lendingDuration.text) *
                                                24 *
                                                60 *
                                                60,
                                      ),
                                    );
                                    if (value) {
                                      pageNotifier
                                          .setLoanPage(LoanPage.adminItem);
                                      await loanersitemsNotifier.setTData(
                                          loaner.value,
                                          await itemListNotifier.copy());
                                      displayLoanToastWithContext(TypeMsg.msg,
                                          LoanTextConstants.addedObject);
                                    } else {
                                      displayLoanToastWithContext(TypeMsg.error,
                                          LoanTextConstants.addingError);
                                    }
                                  });
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
                    if (currentStep.value > 0)
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
