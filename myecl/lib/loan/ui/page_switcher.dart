import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/ui/pages/add_item_page/add_item_page.dart';
import 'package:myecl/loan/ui/pages/add_loan_page/add_loan_page.dart';
import 'package:myecl/loan/ui/pages/detail_page/detail_page.dart';
import 'package:myecl/loan/ui/pages/edit_page/edit_page.dart';
import 'package:myecl/loan/ui/pages/history_page/history_page.dart';
import 'package:myecl/loan/ui/pages/main_page/main_page.dart';
import 'package:myecl/loan/ui/pages/option_page/option_page.dart';

class PageSwitcher extends ConsumerWidget {
  const PageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(loanPageProvider);
    switch(page) {
      case LoanPage.addItem:
        return const AddItemPage();
      case LoanPage.addLoan:
        return const AddLoanPage();
      case LoanPage.detail:
        return const DetailPage();
      case LoanPage.edit:
        return const EditPage();
      case LoanPage.history:
        return const HistoryPage();
      case LoanPage.main:
        return const MainPage();
      case LoanPage.option:
        return const OptionPage();
      case LoanPage.historyDetail:
        return const DetailPage();
      default:
        return const Text('Unknown page');
    }
  }
}