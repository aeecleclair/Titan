import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/item_quantity.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/borrower_provider.dart';
import 'package:myecl/loan/providers/caution_provider.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/loan_list_provider.dart';
import 'package:myecl/loan/providers/loaners_items_map_provider.dart';
import 'package:myecl/loan/providers/loaners_loans_map_provider.dart';
import 'package:myecl/loan/providers/selected_loaner_provider.dart';
import 'package:myecl/loan/providers/item_quantities_provider.dart';
import 'package:myecl/loan/providers/start_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:myecl/tools/ui/builders/waiting_button.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AddEditButton extends HookConsumerWidget {
  final TextEditingController note;
  final bool isEdit;
  final Future Function(Function) onAddEdit;
  const AddEditButton({
    super.key,
    required this.note,
    required this.isEdit,
    required this.onAddEdit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLoaner = ref.watch(selectedLoanerProvider);

    final loanersLoansMapNotifier = ref.read(loanersLoansMapProvider.notifier);

    final loanerItems =
        ref.read(loanersItemsMapProvider.select((map) => map[selectedLoaner]));
    final loanItemQuantities = ref.watch(loanItemQuantitiesMapProvider);
    final loanListNotifier = ref.watch(loanListProvider.notifier);

    final loan = ref.watch(loanProvider);
    final caution = ref.watch(cautionProvider);
    final end = ref.watch(endProvider);
    final start = ref.watch(startProvider);
    final borrower = ref.watch(borrowerProvider);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return WaitingButton(
      builder: (child) => AddEditButtonLayout(child: child),
      onTap: () async {
        if (loanerItems == null) {
          displayToast(context, TypeMsg.error, LoanTextConstants.noItems);
        }
        await onAddEdit(() async {
          if (processDateBack(start).compareTo(processDateBack(end)) > 0) {
            displayToast(
              context,
              TypeMsg.error,
              LoanTextConstants.invalidDates,
            );
          } else if (borrower.id.isEmpty) {
            displayToast(context, TypeMsg.error, LoanTextConstants.noBorrower);
          } else {
            await loanerItems!.when(
              data: (itemList) async {
                await tokenExpireWrapper(ref, () async {
                  List<ItemQuantity> selectedLoanItemQuantities = itemList
                      .where(
                        (item) =>
                            loanItemQuantities[item.id] != null &&
                            loanItemQuantities[item.id]! > 0,
                      )
                      .map(
                        (itemWithPositiveQuantity) => ItemQuantity(
                          itemSimple: itemWithPositiveQuantity.toItemSimple(),
                          quantity:
                              loanItemQuantities[itemWithPositiveQuantity.id]!,
                        ),
                      )
                      .toList();
                  if (selectedLoanItemQuantities.isNotEmpty) {
                    Loan newLoan = Loan(
                      loaner: isEdit ? loan.loaner : selectedLoaner,
                      itemsQuantity: selectedLoanItemQuantities,
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
                      QR.back();
                      if (isEdit) {
                        loanersLoansMapNotifier.updateLoanForLoaner(
                          selectedLoaner,
                          newLoan,
                        );
                        displayToastWithContext(
                          TypeMsg.msg,
                          LoanTextConstants.updatedLoan,
                        );
                      } else {
                        loanersLoansMapNotifier.addLoanForLoaner(
                          selectedLoaner,
                          newLoan,
                        );
                        displayToastWithContext(
                          TypeMsg.msg,
                          LoanTextConstants.updatedLoan,
                        );
                        displayToastWithContext(
                          TypeMsg.msg,
                          LoanTextConstants.addedLoan,
                        );
                      }
                    } else {
                      if (isEdit) {
                        displayToastWithContext(
                          TypeMsg.error,
                          LoanTextConstants.updatingError,
                        );
                      } else {
                        displayToastWithContext(
                          TypeMsg.error,
                          LoanTextConstants.addingError,
                        );
                      }
                    }
                  } else {
                    displayToastWithContext(
                      TypeMsg.error,
                      LoanTextConstants.noItemSelected,
                    );
                  }
                });
              },
              error: (error, s) {
                displayToast(context, TypeMsg.error, error.toString());
              },
              loading: () {
                displayToast(
                  context,
                  TypeMsg.error,
                  LoanTextConstants.addingError,
                );
              },
            );
          }
        });
      },
      child: Text(
        isEdit ? LoanTextConstants.edit : LoanTextConstants.add,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
