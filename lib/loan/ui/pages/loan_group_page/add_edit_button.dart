import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/class/item_quantity.dart';
import 'package:titan/loan/class/loan.dart';
import 'package:titan/loan/providers/admin_loan_list_provider.dart';
import 'package:titan/loan/providers/borrower_provider.dart';
import 'package:titan/loan/providers/caution_provider.dart';
import 'package:titan/loan/providers/end_provider.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/loan_provider.dart';
import 'package:titan/loan/providers/loaner_loan_list_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/loan/providers/selected_items_provider.dart';
import 'package:titan/loan/providers/start_provider.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

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
    final locale = Localizations.localeOf(context);
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

    return WaitingButton(
      builder: (child) => AddEditButtonLayout(child: child),
      onTap: () async {
        await onAddEdit(() async {
          if (processDateBack(
                start,
                locale.toString(),
              ).compareTo(processDateBack(end, locale.toString())) >
              0) {
            displayToast(
              context,
              TypeMsg.error,
              AppLocalizations.of(context)!.loanInvalidDates,
            );
          } else if (borrower.id.isEmpty) {
            displayToast(
              context,
              TypeMsg.error,
              AppLocalizations.of(context)!.loanNoBorrower,
            );
          } else {
            await items.when(
              data: (itemList) async {
                await tokenExpireWrapper(ref, () async {
                  List<ItemQuantity> selected = itemList
                      .where(
                        (element) =>
                            selectedItems[itemList.indexOf(element)] != 0,
                      )
                      .map(
                        (e) => ItemQuantity(
                          itemSimple: e.toItemSimple(),
                          quantity: selectedItems[itemList.indexOf(e)],
                        ),
                      )
                      .toList();
                  if (selected.isNotEmpty) {
                    Loan newLoan = Loan(
                      loaner: isEdit ? loan.loaner : loaner,
                      itemsQuantity: selected,
                      borrower: borrower,
                      caution: caution.text,
                      end: DateTime.parse(
                        processDateBack(end, locale.toString()),
                      ),
                      id: isEdit ? loan.id : "",
                      notes: note.text,
                      start: DateTime.parse(
                        processDateBack(start, locale.toString()),
                      ),
                      returned: false,
                    );
                    final addedLoanMsg = isEdit
                        ? AppLocalizations.of(context)!.loanUpdatedLoan
                        : AppLocalizations.of(context)!.loanAddedLoan;
                    final addingErrorMsg = isEdit
                        ? AppLocalizations.of(context)!.loanUpdatingError
                        : AppLocalizations.of(context)!.loanAddingError;
                    final value = isEdit
                        ? await loanListNotifier.updateLoan(newLoan)
                        : await loanListNotifier.addLoan(newLoan);
                    if (value) {
                      adminLoanListNotifier.setTData(
                        isEdit ? loan.loaner : loaner,
                        await loanListNotifier.copy(),
                      );
                      QR.back();
                      displayToastWithContext(TypeMsg.msg, addedLoanMsg);
                    } else {
                      displayToastWithContext(TypeMsg.error, addingErrorMsg);
                    }
                  } else {
                    displayToastWithContext(
                      TypeMsg.error,
                      AppLocalizations.of(context)!.loanNoItemSelected,
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
                  AppLocalizations.of(context)!.loanAddingError,
                );
              },
            );
          }
        });
      },
      child: Text(
        isEdit
            ? AppLocalizations.of(context)!.loanEdit
            : AppLocalizations.of(context)!.loanAdd,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
