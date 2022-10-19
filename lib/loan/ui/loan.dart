import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/loan/providers/loan_page_provider.dart';
import 'package:myecl/loan/ui/page_switcher.dart';
import 'package:myecl/loan/ui/top_bar.dart';

class LoanHomePage extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  final AnimationController controller;
  const LoanHomePage(
      {Key? key, required this.controllerNotifier, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(loanPageProvider);
    final pageNotifier = ref.watch(loanPageProvider.notifier);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          switch (page) {
            case LoanPage.detail:
              pageNotifier.setLoanPage(LoanPage.main);
              break;
            case LoanPage.editLoan:
              pageNotifier.setLoanPage(LoanPage.groupLoan);
              break;
            case LoanPage.main:
              if (!controller.isCompleted) {
                controllerNotifier.toggle();
                break;
              } else {
                return true;
              }
            case LoanPage.option:
              pageNotifier.setLoanPage(LoanPage.main);
              break;
            case LoanPage.addLoan:
              pageNotifier.setLoanPage(LoanPage.adminLoan);
              break;
            case LoanPage.addItem:
              pageNotifier.setLoanPage(LoanPage.adminItem);
              break;
            case LoanPage.history:
              pageNotifier.setLoanPage(LoanPage.main);
              break;
            case LoanPage.historyDetail:
              pageNotifier.setLoanPage(LoanPage.history);
              break;
            case LoanPage.groupLoan:
              pageNotifier.setLoanPage(LoanPage.adminLoan);
              break;
            case LoanPage.editItem:
              pageNotifier.setLoanPage(LoanPage.adminItem);
              break;
            case LoanPage.adminItem:
              pageNotifier.setLoanPage(LoanPage.option);
              break;
            case LoanPage.adminLoan:
              pageNotifier.setLoanPage(LoanPage.option);
              break;
          }
          return false;
        },
        child: SafeArea(
          child: Column(
            children: [
              TopBar(
                controllerNotifier: controllerNotifier,
              ),
              const Expanded(child: PageSwitcher()),
            ],
          ),
        ),
      ),
    );
  }
}
