import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/ui/pages/detail_pages/detail_loan.dart';
import 'package:myecl/loan/ui/pages/item_group_page/add_edit_item_page.dart';
import 'package:myecl/loan/ui/pages/loan_group_page/add_edit_loan_page.dart';
import 'package:myecl/loan/ui/pages/main_page/main_page.dart';
import 'package:myecl/loan/ui/pages/admin_page/admin_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(loanPageProvider);
    switch (page) {
      case LoanPage.addEditItem:
        return const AddEditItemPage();
      case LoanPage.addEditLoan:
        return const AddEditLoanPage();
      case LoanPage.main:
        return const MainPage();
      case LoanPage.admin:
        return const AdminPage();
      case LoanPage.detailLoanFromMain:
        return const DetailLoanPage();
      case LoanPage.detailLoanFromAdmin:
        return const DetailLoanPage();
    }
  }
}
