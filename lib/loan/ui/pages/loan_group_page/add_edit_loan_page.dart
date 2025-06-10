import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/class/loan.dart';
import 'package:titan/loan/providers/caution_provider.dart';
import 'package:titan/loan/providers/item_focus_provider.dart';
import 'package:titan/loan/providers/item_list_provider.dart';
import 'package:titan/loan/providers/loan_provider.dart';
import 'package:titan/loan/providers/loaner_provider.dart';
import 'package:titan/loan/providers/loaners_items_provider.dart';
import 'package:titan/loan/tools/constants.dart';
import 'package:titan/loan/ui/loan.dart';
import 'package:titan/loan/ui/pages/loan_group_page/add_edit_button.dart';
import 'package:titan/loan/ui/pages/loan_group_page/end_date_entry.dart';
import 'package:titan/loan/ui/pages/loan_group_page/item_bar.dart';
import 'package:titan/loan/ui/pages/loan_group_page/number_selected_text.dart';
import 'package:titan/loan/ui/pages/loan_group_page/search_result.dart';
import 'package:titan/loan/ui/pages/loan_group_page/start_date_entry.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/tools/ui/widgets/styled_search_bar.dart';
import 'package:titan/tools/ui/widgets/text_entry.dart';
import 'package:titan/user/providers/user_list_provider.dart';

class AddEditLoanPage extends HookConsumerWidget {
  const AddEditLoanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final loan = ref.watch(loanProvider);
    final isEdit = loan.id != Loan.empty().id;
    final note = useTextEditingController(text: loan.notes);
    final caution = ref.watch(cautionProvider);
    final cautionNotifier = ref.watch(cautionProvider.notifier);
    cautionNotifier.setCaution(loan.caution);
    final usersNotifier = ref.watch(userList.notifier);
    final loaner = ref.watch(loanerProvider);
    final loanersItemsNotifier = ref.watch(loanersItemsProvider.notifier);
    final itemList = ref.watch(itemListProvider);
    final itemListNotifier = ref.watch(itemListProvider.notifier);
    final queryController = useTextEditingController(
      text: isEdit ? loan.borrower.getName() : "",
    );
    final focus = ref.watch(itemFocusProvider);
    final focusNode = useFocusNode();
    if (focus) {
      focusNode.requestFocus();
    }

    return LoanTemplate(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(height: 30),
              StyledSearchBar(
                label: isEdit
                    ? LoanTextConstants.editLoan
                    : LoanTextConstants.addLoan,
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    loanersItemsNotifier.setTData(
                      loaner,
                      await itemListNotifier.filterItems(value),
                    );
                  } else {
                    loanersItemsNotifier.setTData(loaner, itemList);
                  }
                },
              ),
              const SizedBox(height: 10),
              ItemBar(isEdit: isEdit),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const NumberSelectedText(),
                    const SizedBox(height: 20),
                    TextEntry(
                      label: LoanTextConstants.borrower,
                      onChanged: (value) {
                        tokenExpireWrapper(ref, () async {
                          if (queryController.text.isNotEmpty) {
                            await usersNotifier.filterUsers(
                              queryController.text,
                            );
                          } else {
                            usersNotifier.clear();
                          }
                        });
                      },
                      canBeEmpty: false,
                      controller: queryController,
                    ),
                    const SizedBox(height: 10),
                    SearchResult(queryController: queryController),
                    const SizedBox(height: 30),
                    const StartDateEntry(),
                    const SizedBox(height: 30),
                    const EndDateEntry(),
                    const SizedBox(height: 30),
                    TextEntry(
                      label: LoanTextConstants.note,
                      controller: note,
                      canBeEmpty: true,
                    ),
                    const SizedBox(height: 30),
                    TextEntry(
                      label: LoanTextConstants.caution,
                      controller: caution,
                      canBeEmpty: true,
                    ),
                    const SizedBox(height: 50),
                    AddEditButton(
                      isEdit: isEdit,
                      note: note,
                      onAddEdit: (processingData) async {
                        if (key.currentState == null) {
                          return;
                        }
                        if (key.currentState!.validate()) {
                          processingData();
                        } else {
                          displayToast(
                            context,
                            TypeMsg.error,
                            LoanTextConstants.incorrectOrMissingFields,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 30),
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
