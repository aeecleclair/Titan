import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoanPage { main, addLoan, addItem, editItem, editLoan, admin }


final loanPageProvider = StateNotifierProvider<LoanPageNotifier, LoanPage>((ref) {
  return LoanPageNotifier();
});

class LoanPageNotifier extends StateNotifier<LoanPage> {
  LoanPageNotifier() : super(LoanPage.main);

  void setLoanPage(LoanPage i) {
    state = i;
  }
}
