import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/admin_loan_list_provider.dart';
import 'package:myecl/loan/providers/borrower_provider.dart';
import 'package:myecl/loan/providers/caution_provider.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/item_list_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loaner_loan_list_provider.dart';
import 'package:myecl/loan/providers/loaner_provider.dart';
import 'package:myecl/loan/providers/selected_items_provider.dart';
import 'package:myecl/loan/providers/start_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AddEditButton extends HookConsumerWidget {
  final TextEditingController note;
  final bool isEdit;
  final Future Function(Function) onAddEdit;
  const AddEditButton({
    Key? key,
    required this.note,
    required this.isEdit,
    required this.onAddEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    final adminLoanListNotifier = ref.watch(adminLoanListProvider.notifier);
    final items = ref.watch(itemListProvider);
    final selectedItems = ref.watch(editSelectedListProvider);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final loan = ref.watch(loanProvider);
    final loaner = ref.watch(loanerProvider);
    final caution = ref.watch(cautionProvider);
    final end = ref.watch(endProvider);
    final start = ref.watch(startProvider);
    final borrower = ref.watch(borrowerProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return ShrinkButton(
      waitChild: Container(
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
                offset: const Offset(3, 3),
              ),
            ],
          ),
          child: const Center(
            child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
            ),
          )),
      onTap: () async {
        await onAddEdit(() async {
          if (processDateBack(start).compareTo(processDateBack(end)) > 0) {
            displayToast(
                context, TypeMsg.error, LoanTextConstants.invalidDates);
          } else if (borrower.id.isEmpty) {
            displayToast(context, TypeMsg.error, LoanTextConstants.noBorrower);
          } else {
            await items.when(
              data: (itemList) async {
                await tokenExpireWrapper(ref, () async {
                  final sortedAvailable = itemList
                      .where((element) => element.loanedQuantity < element.totalQuantity)
                      .toList()
                    ..sort((a, b) => a.name.compareTo(b.name));
                  final sortedUnavailable = itemList
                      .where((element) => element.loanedQuantity >= element.totalQuantity)
                      .toList()
                    ..sort((a, b) => a.name.compareTo(b.name));
                  itemList = sortedAvailable + sortedUnavailable;
                  List<ItemQuantity> selected = itemList
                      .where(
                          (element) => selectedItems[itemList.indexOf(element)] != 0)
                      .map((e) => ItemQuantity(itemSimple: e.simple(), quantity: selectedItems[itemList.indexOf(e)])).toList();
                  if (selected.isNotEmpty) {
                    Loan newLoan = Loan(
                      loaner: isEdit ? loan.loaner : loaner,
                      itemsQuantity: selected,
                      borrower: borrower,
                      caution: caution.text,
                      end: DateTime.parse(processDateBack(end)),
                      id: isEdit ? loan.id : "",
                      notes: note.text,
                      start: DateTime.parse(processDateBack(start)),
                      returned: false,
                    );
                    final value = isEdit
                        ? await loanListNotifier.updateLoan(newLoan)
                        : await loanListNotifier.addLoan(newLoan);
                    if (value) {
                      await adminLoanListNotifier.setTData(
                          isEdit ? loan.loaner : loaner,
                          await loanListNotifier.copy());
                      pageNotifier.setLoanPage(LoanPage.admin);
                      if (isEdit) {
                        displayToastWithContext(
                            TypeMsg.msg, LoanTextConstants.updatedLoan);
                      } else {
                        displayToastWithContext(
                            TypeMsg.msg, LoanTextConstants.addedLoan);
                      }
                    } else {
                      if (isEdit) {
                        displayToastWithContext(
                            TypeMsg.error, LoanTextConstants.updatingError);
                      } else {
                        displayToastWithContext(
                            TypeMsg.error, LoanTextConstants.addingError);
                      }
                    }
                  } else {
                    displayToastWithContext(
                        TypeMsg.error, LoanTextConstants.noItemSelected);
                  }
                });
              },
              error: (error, s) {
                displayToast(context, TypeMsg.error, error.toString());
              },
              loading: () {
                displayToast(
                    context, TypeMsg.error, LoanTextConstants.addingError);
              },
            );
          }
        });
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
                offset: const Offset(3, 3), // changes position of shadow
              ),
            ],
          ),
          child: Text(isEdit ? LoanTextConstants.edit : LoanTextConstants.add,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold))),
    );
  }
}
