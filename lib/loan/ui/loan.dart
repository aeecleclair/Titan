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
            case LoanPage.editLoan:
              pageNotifier.setLoanPage(LoanPage.main);
              break;
            case LoanPage.main:
              if (!controller.isCompleted) {
                controllerNotifier.toggle();
                break;
              } else {
                return true;
              }
            case LoanPage.addLoan:
              pageNotifier.setLoanPage(LoanPage.admin);
              break;
            case LoanPage.addItem:
              pageNotifier.setLoanPage(LoanPage.admin);
              break;
            case LoanPage.editItem:
              pageNotifier.setLoanPage(LoanPage.admin);
              break;
            case LoanPage.admin:
              pageNotifier.setLoanPage(LoanPage.main);
              break;
            case LoanPage.detailLoanFromMain:
              pageNotifier.setLoanPage(LoanPage.main);
              break;
            case LoanPage.detailLoanFromAdmin:
              pageNotifier.setLoanPage(LoanPage.admin);
              break;
          }
          return false;
        },
        child: SafeArea(
          child: IgnorePointer(
            ignoring: controller.isCompleted,
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
      ),
    );
  }
}
