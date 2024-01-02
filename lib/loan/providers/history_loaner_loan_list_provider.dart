import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/tools/functions.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class HistoryLoanerLoanListNotifier extends ListNotifier2<Loan> {
  final Openapi loanRepository;
  HistoryLoanerLoanListNotifier({required this.loanRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadLoan(String loanerId) async {
    return await loadList(
        () async => loanRepository.loansLoanersLoanerIdLoansGet(
              loanerId: loanerId,
              returned: true,
            ));
  }

  Future<AsyncValue<List<Loan>>> copy() async {
    return state.whenData((loans) => loans.sublist(0));
  }

  Future<AsyncValue<List<Loan>>> filterLoans(String query) async {
    return state.whenData((loans) => loans
        .where((loan) =>
            getName(loan.borrower)
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            loan.itemsQty
                .map((e) => e.itemSimple.name
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                .contains(true))
        .toList());
  }
}

final historyLoanerLoanListProvider = StateNotifierProvider<
    HistoryLoanerLoanListNotifier, AsyncValue<List<Loan>>>((ref) {
  final loanRepository = ref.watch(repositoryProvider);
  HistoryLoanerLoanListNotifier historyLoanerLoanListNotifier =
      HistoryLoanerLoanListNotifier(loanRepository: loanRepository);
  tokenExpireWrapperAuth(ref, () async {
    final loanerId = ref.watch(loanerIdProvider);
    if (loanerId != "") {
      historyLoanerLoanListNotifier.loadLoan(loanerId);
    }
  });
  return historyLoanerLoanListNotifier;
});
