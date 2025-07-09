import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/class/item.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/item_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/loan/providers/loaners_items_provider.dart';
import 'package:titan/loan/ui/loan.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/layouts/add_edit_button_layout.dart';
import 'package:titan/tools/ui/widgets/align_left_text.dart';
import 'package:titan/tools/ui/builders/waiting_button.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:titan/l10n/app_localizations.dart';

class AddEditItemPage extends HookConsumerWidget {
  const AddEditItemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final loaner = ref.watch(loanerProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final loanersItemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final item = ref.watch(itemProvider);
    final isEdit = item.id != Item.empty().id;
    final name = useTextEditingController(text: item.name);
    final quantity = useTextEditingController(
      text: item.totalQuantity.toString(),
    );
    final caution = useTextEditingController(
      text: isEdit ? item.caution.toString() : '',
    );
    final lendingDuration = useTextEditingController(
      text: isEdit ? item.suggestedLendingDuration.toString() : '',
    );

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return LoanTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(height: 30),
              AlignLeftText(
                isEdit
                    ? AppLocalizations.of(context)!.loanEditItem
                    : AppLocalizations.of(context)!.loanAddObject,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    TextEntry(
                      label: AppLocalizations.of(context)!.loanName,
                      controller: name,
                    ),
                    const SizedBox(height: 30),
                    TextEntry(
                      keyboardType: TextInputType.number,
                      label: AppLocalizations.of(context)!.loanQuantity,
                      isInt: true,
                      controller: quantity,
                    ),
                    const SizedBox(height: 30),
                    TextEntry(
                      keyboardType: TextInputType.number,
                      controller: caution,
                      isInt: true,
                      label: AppLocalizations.of(context)!.loanCaution,
                      suffix: '€',
                    ),
                    const SizedBox(height: 30),
                    TextEntry(
                      keyboardType: TextInputType.number,
                      controller: lendingDuration,
                      isInt: true,
                      label: AppLocalizations.of(context)!.loanLendingDuration,
                      suffix: AppLocalizations.of(context)!.loanDays,
                    ),
                    const SizedBox(height: 50),
                    WaitingButton(
                      builder: (child) => AddEditButtonLayout(
                        color: Colors.black,
                        child: child,
                      ),
                      onTap: () async {
                        final updatedItemMsg = isEdit
                            ? AppLocalizations.of(context)!.loanUpdatedItem
                            : AppLocalizations.of(context)!.loanAddedObject;
                        final updatedItemErrorMsg = isEdit
                            ? AppLocalizations.of(context)!.loanUpdatingError
                            : AppLocalizations.of(context)!.loanAddingError;
                        if (key.currentState == null) {
                          return;
                        }
                        if (key.currentState!.validate()) {
                          await tokenExpireWrapper(ref, () async {
                            Item newItem = Item(
                              id: isEdit ? item.id : '',
                              name: name.text,
                              caution: int.parse(caution.text),
                              suggestedLendingDuration: int.parse(
                                lendingDuration.text,
                              ),
                              loanedQuantity: 1,
                              totalQuantity: int.parse(quantity.text),
                            );
                            final value = isEdit
                                ? await itemListNotifier.updateItem(
                                    newItem,
                                    loaner.id,
                                  )
                                : await itemListNotifier.addItem(
                                    newItem,
                                    loaner.id,
                                  );
                            if (value) {
                              QR.back();
                              loanersItemsNotifier.setTData(
                                loaner,
                                await itemListNotifier.copy(),
                              );
                              displayToastWithContext(
                                TypeMsg.msg,
                                updatedItemMsg,
                              );
                            } else {
                              displayToastWithContext(
                                TypeMsg.error,
                                updatedItemErrorMsg,
                              );
                            }
                          });
                        } else {
                          displayToast(
                            context,
                            TypeMsg.error,
                            AppLocalizations.of(
                              context,
                            )!.loanIncorrectOrMissingFields,
                          );
                        }
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
