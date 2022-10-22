import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/loan/ui/pages/item_group_page/add_item_page.dart';
import 'package:myecl/loan/ui/pages/item_group_page/edit_item_page.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/add_loan_page.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/edit_loan_page.dart';
import 'package:myecl/loan/ui/pages/history_page/history_page.dart';
import 'package:myecl/loan/ui/pages/main_page/main_page.dart';
import 'package:myecl/loan/ui/pages/new_admin_page/new_admin_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(loanPageProvider);
    switch (page) {
      case LoanPage.addItem:
        return const AddItemPage();
      case LoanPage.addLoan:
        print("addLoan");
        return const AddLoanPage();
      case LoanPage.detail:
        return const DetailPage(isAdmin: false);
      case LoanPage.editLoan:
        return const EditLoanPage();
      case LoanPage.main:
        return const MainPage();
      case LoanPage.groupLoan:
        return const DetailPage(isAdmin: true);
      case LoanPage.editItem:
        return const EditItemPage();
      case LoanPage.admin:
        return const NewAdminPage();
    }
  }
}
