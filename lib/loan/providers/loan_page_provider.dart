import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoanPage { main, detail, addLoan, addItem, history, editItem, editLoan, historyDetail, groupLoan, admin }


final loanPageProvider = StateNotifierProvider<LoanPageNotifier, LoanPage>((ref) {
  return LoanPageNotifier();
});

class LoanPageNotifier extends StateNotifier<LoanPage> {
  LoanPageNotifier() : super(LoanPage.main);

  void setLoanPage(LoanPage i) {
    state = i;
  }
}
