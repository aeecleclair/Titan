import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/caution_provider.dart';
import 'package:myecl/loan/providers/end_provider.dart';
import 'package:myecl/loan/providers/loan_provider.dart';
import 'package:myecl/loan/providers/start_provider.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/add_edit_button.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/caution_text_entry.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/end_date_entry.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/item_bar.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/number_selected_text.dart';
import 'package:myecl/loan/tools/functions.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/check_item_card.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/date_entry.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/item_bar.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/search_result.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/start_date_entry.dart';
import 'package:myecl/loan/ui/text_entry.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_list_provider.dart';

class AddEditLoanPage extends HookConsumerWidget {
  const AddEditLoanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = GlobalKey<FormState>();
    final items = ref.watch(itemListProvider);
    final selectedItems = ref.watch(editSelectedListProvider);
    final loanListNotifier = ref.watch(loanerLoanListProvider.notifier);
    final loan = ref.watch(loanProvider);
    final isEdit = loan.id != Loan.empty().id;
    final note = useTextEditingController(text: loan.notes);
    final startNotifier = ref.watch(startProvider.notifier);
    startNotifier.setStart(
        isEdit ? processDate(loan.start) : processDate(DateTime.now()));
    final endNotifier = ref.watch(endProvider.notifier);
    endNotifier.setEnd(isEdit ? processDate(loan.end) : "");
    final cautionNotifier = ref.watch(cautionProvider.notifier);
    cautionNotifier.setCaution(loan.caution);
    final usersNotifier = ref.watch(userList.notifier);
    final queryController =
        useTextEditingController(text: isEdit ? loan.borrower.getName() : "");

    final initialDate = useState(isEdit ? loan.start : DateTime.now());

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: key,
          child: Column(children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      isEdit
                          ? LoanTextConstants.editLoan
                          : LoanTextConstants.addLoan,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 205, 205, 205)))),
            ),
            const SizedBox(height: 30),
            ItemBar(
              isEdit: isEdit,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(children: [
                const SizedBox(height: 20),
                const NumberSelectedText(),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    tokenExpireWrapper(ref, () async {
                      if (queryController.text.isNotEmpty) {
                        await usersNotifier.filterUsers(queryController.text);
                      } else {
                        usersNotifier.clear();
                      }
                    });
                  },
                  cursorColor: Colors.black,
                  controller: queryController,
                  decoration: const InputDecoration(
                    labelText: LoanTextConstants.borrower,
                    floatingLabelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SearchResult(queryController: queryController),
                const SizedBox(height: 30),
                StartDateEntry(initialDate: initialDate),
                const SizedBox(height: 30),
                EndDateEntry(
                  initialDate: initialDate,
                ),
                const SizedBox(height: 30),
                TextEntry(
                  keyboardType: TextInputType.text,
                  label: LoanTextConstants.note,
                  suffix: '',
                  isInt: false,
                  controller: note,
                ),
                const SizedBox(height: 30),
                const CautionTextEntry(),
                const SizedBox(height: 50),
                AddEditButton(
                  isEdit: isEdit,
                  note: note,
                  onAddEdit: (p0) async {
                    if (key.currentState == null) {
                      return;
                    }
                    if (key.currentState!.validate()) {
                      p0();
                    } else {
                      displayToast(context, TypeMsg.error,
                          LoanTextConstants.incorrectOrMissingFields);
                    }
                  },
                ),
                const SizedBox(height: 30),
              ]),
            ),
          ]),
        ));
  }
}
