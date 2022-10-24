import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/loaner_chip.dart';
import 'package:myecl/loan/ui/text_entry.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/check_item_card.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/date_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddLoanPage extends HookConsumerWidget {
  const AddLoanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final adminLoanListNotifier = ref.watch(adminLoanListProvider.notifier);
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
    final start = useTextEditingController(text: processDate(DateTime.now()));
    final end = useTextEditingController();
    final note = useTextEditingController();
    final queryController = useTextEditingController();
    final caution = useTextEditingController();
    final focus = useState(false);
    final borrower = useState(SimpleUser.empty());
    final numberSelected = useState(0);
    final displayUserSearch = useState(false);
    void displayLoanToastWithContext(TypeMsg type, String msg) {
      displayLoanToast(context, type, msg);
    }

    // Widget w = const Center(
    //   child: CircularProgressIndicator(
    //     valueColor: AlwaysStoppedAnimation<Color>(LoanColorConstants.darkGrey),
    //   ),
    // );

    // associations.when(
    //   data: (listAsso) {
    //     if (listAsso.isNotEmpty) {
    //       List<Step> steps = [
    //         Step(
    //           title: const Text(LoanTextConstants.association),
    //           content: Column(
    //               children: listAsso
    //                   .map(
    //                     (e) => RadioListTile(
    //                         title: Text(capitalize(e.name),
    //                             style: const TextStyle(
    //                                 fontSize: 18, fontWeight: FontWeight.w500)),
    //                         selected: asso.value.name == e.name,
    //                         value: e.name,
    //                         activeColor: LoanColorConstants.orange,
    //                         groupValue: asso.value.name,
    //                         onChanged: (s) async {
    //                           asso.value = e;
    //                           tokenExpireWrapper(ref, () async {
    //                             itemListNotifier.setId(e.id);
    //                             items.value =
    //                                 await itemListNotifier.loadItemList();
    //                           });
    //                         }),
    //                   )
    //                   .toList()),
    //           isActive: currentStep.value >= 0,
    //           state: currentStep.value >= 0
    //               ? StepState.complete
    //               : StepState.disabled,
    //         ),
    //         Step(
    //           title: const Text(LoanTextConstants.objects),
    //           content: Column(
    //             children: items.value.when(data: (itemList) {
    //               return itemList
    //                   .map(
    //                     (e) => CheckboxListTile(
    //                       title: Text(e.name,
    //                           style: TextStyle(
    //                             fontSize: 18,
    //                             fontWeight: FontWeight.w500,
    //                             color: e.available
    //                                 ? LoanColorConstants.orange
    //                                 : Colors.grey.shade700,
    //                             decoration: e.available
    //                                 ? null
    //                                 : TextDecoration.lineThrough,
    //                           )),
    //                       value: selectedItems[itemList.indexOf(e)],
    //                       onChanged: (s) {
    //                         if (e.available) {
    //                           selectedItemsNotifier.toggle(itemList.indexOf(e));
    //                         }
    //                       },
    //                     ),
    //                   )
    //                   .toList();
    //             }, error: (error, s) {
    //               return [
    //                 Text(error.toString(),
    //                     style: const TextStyle(
    //                         fontSize: 18, fontWeight: FontWeight.w500)),
    //               ];
    //             }, loading: () {
    //               return [
    //                 const CircularProgressIndicator(
    //                   valueColor: AlwaysStoppedAnimation<Color>(
    //                       LoanColorConstants.orange),
    //                 ),
    //               ];
    //             }),
    //           ),
    //           isActive: currentStep.value >= 0,
    //           state: currentStep.value >= 1
    //               ? StepState.complete
    //               : StepState.disabled,
    //         ),
    //         Step(
    //           title: const Text(LoanTextConstants.dates),
    //           content: Column(
    //             children: [
    //               DateEntry(
    //                   title: LoanTextConstants.beginDate, controller: start),
    //               DateEntry(title: LoanTextConstants.endDate, controller: end),
    //             ],
    //           ),
    //           isActive: currentStep.value >= 0,
    //           state: currentStep.value >= 3
    //               ? StepState.complete
    //               : StepState.disabled,
    //         ),
    //         Step(
    //           title: const Text(LoanTextConstants.borrower),
    //           content: users.value.when(data: (u) {
    //             return Column(children: <Widget>[
    //               TextField(
    //                 onChanged: (value) {
    //                   focus.value = true;
    //                   tokenExpireWrapper(ref, () async {
    //                     final value = await usersNotifier
    //                         .filterUsers(queryController.text);
    //                     users.value = value;
    //                   });
    //                 },
    //                 controller: queryController,
    //                 autofocus: focus.value,
    //                 decoration: const InputDecoration(
    //                     labelText: LoanTextConstants.looking,
    //                     hintText: LoanTextConstants.looking,
    //                     prefixIcon: Icon(Icons.search),
    //                     border: OutlineInputBorder(
    //                         borderRadius:
    //                             BorderRadius.all(Radius.circular(25.0)))),
    //               ),
    //               const SizedBox(
    //                 height: 10,
    //               ),
    //               ...u.map(
    //                 (e) => GestureDetector(
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Container(
    //                               width: 20,
    //                             ),
    //                             Expanded(
    //                               child: Text(
    //                                 e.getName(),
    //                                 style: TextStyle(
    //                                   fontSize: 13,
    //                                   fontWeight: (borrower.value.id == e.id)
    //                                       ? FontWeight.bold
    //                                       : FontWeight.w400,
    //                                 ),
    //                                 overflow: TextOverflow.ellipsis,
    //                               ),
    //                             ),
    //                           ]),
    //                     ),
    //                     onTap: () {
    //                       borrower.value = e;
    //                     }),
    //               )
    //             ]);
    //           }, error: (error, s) {
    //             return Text(error.toString(),
    //                 style: const TextStyle(
    //                     fontSize: 18, fontWeight: FontWeight.w500));
    //           }, loading: () {
    //             return const CircularProgressIndicator(
    //               valueColor:
    //                   AlwaysStoppedAnimation<Color>(LoanColorConstants.orange),
    //             );
    //           }),
    //           isActive: currentStep.value >= 0,
    //           state: currentStep.value >= 4
    //               ? StepState.complete
    //               : StepState.disabled,
    //         ),
    //         Step(
    //           title: const Text(LoanTextConstants.note),
    //           content: Column(
    //             children: <Widget>[
    //               TextFormField(
    //                 decoration: const InputDecoration(
    //                     labelText: LoanTextConstants.note),
    //                 controller: note,
    //                 validator: (value) {
    //                   if (value == null) {
    //                     return LoanTextConstants.noValue;
    //                   }
    //                   return null;
    //                 },
    //               ),
    //             ],
    //           ),
    //           isActive: currentStep.value >= 0,
    //           state: currentStep.value >= 5
    //               ? StepState.complete
    //               : StepState.disabled,
    //         ),
    //         Step(
    //           title: const Text(LoanTextConstants.caution),
    //           content: TextFormField(
    //             decoration: InputDecoration(
    //                 // labelText: LoanTextConstants.caution,
    //                 hintText: items.value.when(
    //                     data: (itemList) =>
    //                         "${itemList.where((element) => selectedItems[itemList.indexOf(element)]).toList().fold<double>(0, (previousValue, element) => previousValue + element.caution)}€",
    //                     error: (Object error, StackTrace? stackTrace) => "",
    //                     loading: () => "")),
    //             controller: caution,
    //             validator: (value) {
    //               if (value == null) {
    //                 return LoanTextConstants.noValue;
    //               }
    //               return null;
    //             },
    //           ),
    //           isActive: currentStep.value >= 0,
    //           state: currentStep.value >= 6
    //               ? StepState.complete
    //               : StepState.disabled,
    //         ),
    //         Step(
    //           title: const Text(LoanTextConstants.confirmation),
    //           content: Column(
    //             children: <Widget>[
    //               Row(
    //                 children: [
    //                   const Text("${LoanTextConstants.association} : "),
    //                   Text(asso.value.name),
    //                 ],
    //               ),
    //               Row(
    //                 children: [
    //                   const Text("${LoanTextConstants.borrower} : "),
    //                   Text(borrower.value.getName()),
    //                 ],
    //               ),
    //               Column(
    //                 children: [
    //                   const Text("${LoanTextConstants.objects} : "),
    //                   ...items.value.when(
    //                     data: (itemList) {
    //                       return itemList
    //                           .where((element) =>
    //                               selectedItems[itemList.indexOf(element)])
    //                           .map(
    //                             (e) => Text(
    //                               e.name,
    //                               style: const TextStyle(
    //                                   fontSize: 18,
    //                                   fontWeight: FontWeight.w500),
    //                             ),
    //                           )
    //                           .toList();
    //                     },
    //                     error: (error, s) {
    //                       return [Text(error.toString())];
    //                     },
    //                     loading: () {
    //                       return [
    //                         const Center(
    //                             child: CircularProgressIndicator(
    //                           valueColor: AlwaysStoppedAnimation(
    //                               LoanColorConstants.orange),
    //                         ))
    //                       ];
    //                     },
    //                   )
    //                 ],
    //               ),
    //               Row(
    //                 children: [
    //                   const Text("${LoanTextConstants.beginDate} : "),
    //                   Text(start.text),
    //                 ],
    //               ),
    //               Row(
    //                 children: [
    //                   const Text("${LoanTextConstants.endDate} : "),
    //                   Text(end.text),
    //                 ],
    //               ),
    //               Row(
    //                 children: [
    //                   const Text("${LoanTextConstants.note} : "),
    //                   Text(note.text),
    //                 ],
    //               ),
    //               Row(
    //                 children: [
    //                   const Text("${LoanTextConstants.caution} : "),
    //                   items.value.when(
    //                     data: (itemList) {
    //                       return Text(caution.text.isNotEmpty
    //                           ? caution.text
    //                           : caution.text.isNotEmpty
    //                               ? caution.text
    //                               : "${itemList.where((element) => selectedItems[itemList.indexOf(element)]).toList().fold<double>(0, (previousValue, element) => previousValue + element.caution)}€");
    //                     },
    //                     error: (error, s) {
    //                       return Text(error.toString());
    //                     },
    //                     loading: () {
    //                       return const Center(
    //                           child: CircularProgressIndicator(
    //                         valueColor: AlwaysStoppedAnimation(
    //                             LoanColorConstants.orange),
    //                       ));
    //                     },
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //           isActive: currentStep.value >= 0,
    //           state: currentStep.value >= 7
    //               ? StepState.complete
    //               : StepState.disabled,
    //         ),
    //       ];

    //       void continued() {
    //         currentStep.value < steps.length ? currentStep.value += 1 : null;
    //       }

    //       void cancel() {
    //         currentStep.value > 0 ? currentStep.value -= 1 : null;
    //       }

    //       w = Form(
    //         autovalidateMode: AutovalidateMode.onUserInteraction,
    //         key: key,
    //         child: Stepper(
    //           physics: const BouncingScrollPhysics(),
    //           currentStep: currentStep.value,
    //           onStepTapped: (step) => currentStep.value = step,
    //           onStepContinue: continued,
    //           onStepCancel: cancel,
    //           controlsBuilder: (context, ControlsDetails controls) {
    //             final isLastStep = currentStep.value == steps.length - 1;
    //             return Row(
    //               children: [
    //                 if (currentStep.value > 0)
    //                   Expanded(
    //                     child: ElevatedButton(
    //                       onPressed: controls.onStepCancel,
    //                       child: const Text(LoanTextConstants.previous),
    //                     ),
    //                   ),
    //                 const SizedBox(
    //                   width: 10,
    //                 ),
    //                 Expanded(
    //                   child: ElevatedButton(
    //                     onPressed: !isLastStep
    //                         ? controls.onStepContinue
    //                         : () {
    //                             if (key.currentState == null) {
    //                               return;
    //                             }
    //                             if (key.currentState!.validate() &&
    //                                 borrower.value.id.isNotEmpty) {
    //                               if (start.text.compareTo(end.text) >= 0) {
    //                                 displayLoanToast(context, TypeMsg.error,
    //                                     LoanTextConstants.invalidDates);
    //                               } else {
    //                                 items.value.when(
    //                                   data: (itemList) {
    //                                     tokenExpireWrapper(ref, () async {
    //                                       List<Item> selected = itemList
    //                                           .where((element) => selectedItems[
    //                                               itemList.indexOf(element)])
    //                                           .toList();
    //                                       if (selected.isNotEmpty) {
    //                                         final value =
    //                                             await loanListNotifier.addLoan(
    //                                           Loan(
    //                                             loaner: loaner,
    //                                             items: selected,
    //                                             borrower: borrower.value,
    //                                             caution: caution.text.isNotEmpty
    //                                                 ? caution.text
    //                                                 : "${selected.fold<double>(0, (previousValue, element) => previousValue + element.caution)}€",
    //                                             end: DateTime.parse(end.text),
    //                                             id: "",
    //                                             notes: note.text,
    //                                             start:
    //                                                 DateTime.parse(start.text),
    //                                             returned: false,
    //                                           ),
    //                                         );
    //                                         if (value) {
    //                                           await adminLoanListNotifier
    //                                               .setTData(
    //                                                   loaner,
    //                                                   await loanListNotifier
    //                                                       .copy());
    //                                           pageNotifier
    //                                               .setLoanPage(LoanPage.admin);
    //                                           displayLoanToastWithContext(
    //                                               TypeMsg.msg,
    //                                               LoanTextConstants.addedLoan);
    //                                         } else {
    //                                           displayLoanToastWithContext(
    //                                               TypeMsg.error,
    //                                               LoanTextConstants
    //                                                   .addingError);
    //                                         }
    //                                       } else {
    //                                         displayLoanToastWithContext(
    //                                             TypeMsg.error,
    //                                             LoanTextConstants
    //                                                 .noItemSelected);
    //                                       }
    //                                     });
    //                                   },
    //                                   error: (error, s) {
    //                                     displayLoanToast(context, TypeMsg.error,
    //                                         error.toString());
    //                                   },
    //                                   loading: () {
    //                                     displayLoanToast(context, TypeMsg.error,
    //                                         LoanTextConstants.addingError);
    //                                   },
    //                                 );
    //                               }
    //                             } else {
    //                               displayLoanToast(
    //                                   context,
    //                                   TypeMsg.error,
    //                                   LoanTextConstants
    //                                       .incorrectOrMissingFields);
    //                             }
    //                           },
    //                     child: (isLastStep)
    //                         ? const Text(LoanTextConstants.add)
    //                         : const Text(LoanTextConstants.next),
    //                   ),
    //                 ),
    //               ],
    //             );
    //           },
    //           steps: steps,
    //         ),
    //       );
    //     } else {
    //       w = const Text(LoanTextConstants.noAssociationsFounded);
    //     }
    //   },
    //   error: (e, s) {
    //     w = Text(e.toString());
    //   },
    //   loading: () {},
    // );

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
            key: key,
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(LoanTextConstants.addLoan,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 30),
              associations.when(
                  data: (data) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 15),
                            ...data.map(
                              (e) => LoanerChip(
                                label: capitalize(e.name),
                                selected: asso.value.id == e.id,
                                onTap: () async {
                                  asso.value = e;
                                  tokenExpireWrapper(ref, () async {
                                    itemListNotifier.setId(e.id);
                                    items.value =
                                        await itemListNotifier.loadItemList();
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 15),
                          ],
                        ),
                      ),
                  error: (Object error, StackTrace? stackTrace) => Center(
                        child: Text("Error : $error"),
                      ),
                  loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      )),
              const SizedBox(height: 20),
              items.value.when(data: (itemList) {
                if (itemList.isNotEmpty) {
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 15),
                            ...itemList.map(
                              (e) => CheckItemCard(
                                item: e,
                                onCheck: () async {
                                  if (e.available) {
                                    selectedItemsNotifier
                                        .toggle(itemList.indexOf(e))
                                        .then(
                                      (value) {
                                        List<Item> selected = itemList
                                            .where((element) => value[
                                                itemList.indexOf(element)])
                                            .toList();
                                        numberSelected.value = selected.length;
                                        if (numberSelected.value > 0) {
                                          caution.text =
                                              "${selected.fold<double>(0, (previousValue, element) => previousValue + element.caution).toStringAsFixed(2)}€";
                                          end.text = processDate(DateTime.now()
                                              .add(Duration(
                                                  days: (selected.fold<double>(
                                                          double.infinity,
                                                          (previousValue,
                                                                  element) =>
                                                              previousValue >
                                                                      element
                                                                          .suggestedLendingDuration
                                                                  ? element
                                                                      .suggestedLendingDuration
                                                                  : previousValue) ~/
                                                      (24 * 60 * 60)))));
                                        } else {
                                          end.text = "";
                                          caution.text = "";
                                        }
                                      },
                                    );
                                  }
                                },
                                isSelected: selectedItems[itemList.indexOf(e)],
                              ),
                            ),
                            const SizedBox(width: 15),
                          ]));
                } else {
                  return const SizedBox(
                    height: 160,
                    child: Center(
                        child: Text(LoanTextConstants.noItems,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500))),
                  );
                }
              }, error: (error, s) {
                return SizedBox(
                  height: 160,
                  child: Text(error.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                );
              }, loading: () {
                return const SizedBox(
                  height: 160,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          LoanColorConstants.orange)),
                );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(children: [
                  const SizedBox(height: 20),
                  Text(
                      '${numberSelected.value} ${LoanTextConstants.itemsSelected}'),
                  const SizedBox(height: 20),
                  users.value.when(data: (u) {
                    return Column(children: <Widget>[
                      TextField(
                        onChanged: (value) {
                          focus.value = true;
                          if (value.isNotEmpty) {
                            tokenExpireWrapper(ref, () async {
                              final value = await usersNotifier
                                  .filterUsers(queryController.text);
                              users.value = value;
                              displayUserSearch.value = true;
                            });
                          }
                        },
                        controller: queryController,
                        autofocus: focus.value,
                        decoration: const InputDecoration(
                          floatingLabelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (displayUserSearch.value)
                        ...u.map(
                          (e) => GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Text(
                                          e.getName(),
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight:
                                                (borrower.value.id == e.id)
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
                                queryController.text = e.getName();
                                focus.value = false;
                                displayUserSearch.value = false;
                              }),
                        )
                    ]);
                  }, error: (error, s) {
                    return Text(error.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500));
                  }, loading: () {
                    return const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          LoanColorConstants.orange),
                    );
                  }),
                  const SizedBox(height: 30),
                  DateEntry(
                      title: LoanTextConstants.beginDate, controller: start),
                  const SizedBox(height: 30),
                  DateEntry(title: LoanTextConstants.endDate, controller: end),
                  const SizedBox(height: 30),
                  TextEntry(
                    keyboardType: TextInputType.text,
                    label: LoanTextConstants.note,
                    suffix: '',
                    isInt: false,
                    controller: note,
                  ),
                  const SizedBox(height: 30),
                  TextEntry(
                    keyboardType: TextInputType.text,
                    controller: caution,
                    isInt: false,
                    label: LoanTextConstants.caution,
                    suffix: '',
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      if (key.currentState == null) {
                        return;
                      }
                      if (key.currentState!.validate() &&
                          borrower.value.id.isNotEmpty) {
                        if (processDateBack(start.text)
                                .compareTo(processDateBack(end.text)) >=
                            0) {
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
                                if (selected.isNotEmpty) {
                                  final value = await loanListNotifier.addLoan(
                                    Loan(
                                      loaner: asso.value,
                                      items: selected,
                                      borrower: borrower.value,
                                      caution: caution.text.isNotEmpty
                                          ? caution.text
                                          : "${selected.fold<double>(0, (previousValue, element) => previousValue + element.caution)}€",
                                      end: DateTime.parse(
                                          processDateBack(end.text)),
                                      id: "",
                                      notes: note.text,
                                      start: DateTime.parse(
                                          processDateBack(start.text)),
                                      returned: false,
                                    ),
                                  );
                                  if (value) {
                                    await adminLoanListNotifier.setTData(
                                        asso.value,
                                        await loanListNotifier.copy());
                                    pageNotifier.setLoanPage(LoanPage.admin);
                                    displayLoanToastWithContext(TypeMsg.msg,
                                        LoanTextConstants.addedLoan);
                                  } else {
                                    displayLoanToastWithContext(TypeMsg.error,
                                        LoanTextConstants.addingError);
                                  }
                                } else {
                                  displayLoanToastWithContext(TypeMsg.error,
                                      LoanTextConstants.noItemSelected);
                                }
                              });
                            },
                            error: (error, s) {
                              displayLoanToast(
                                  context, TypeMsg.error, error.toString());
                            },
                            loading: () {
                              displayLoanToast(context, TypeMsg.error,
                                  LoanTextConstants.addingError);
                            },
                          );
                        }
                      } else {
                        displayLoanToast(context, TypeMsg.error,
                            LoanTextConstants.incorrectOrMissingFields);
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8, bottom: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(
                                  3, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Text(LoanTextConstants.add,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(height: 30),
                ]),
              )
            ])));
  }
}
