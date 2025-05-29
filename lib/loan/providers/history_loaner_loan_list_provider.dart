import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/loan/class/loan.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/repositories/loan_repository.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class HistoryLoanerLoanListNotifier extends ListNotifier<Loan> {
  final LoanRepository loanRepository = LoanRepository();
  HistoryLoanerLoanListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    loanRepository.setToken(token);
  }

  Future<AsyncValue<List<Loan>>> loadLoan(String loanerId) async {
    return await loadList(() async => loanRepository.getHistory(loanerId));
  }

  Future<bool> addLoan(Loan loan) async {
    return await add(loanRepository.createLoan, loan);
  }

  Future<bool> updateLoan(Loan loan) async {
    return await update(
      loanRepository.updateLoan,
      (loans, loan) => loans..[loans.indexWhere((l) => l.id == loan.id)] = loan,
      loan,
    );
  }

  Future<bool> deleteLoan(Loan loan) async {
    return await delete(
      loanRepository.deleteLoan,
      (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
      loan.id,
      loan,
    );
  }

  Future<bool> returnLoan(Loan loan) async {
    return await delete(
      loanRepository.returnLoan,
      (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
      loan.id,
      loan,
    );
  }

  Future<bool> extendLoan(Loan loan, int delay) async {
    return await update(
      (l) async {
        return loanRepository.extendLoan(l, delay);
      },
      (loans, loan) => loans..[loans.indexWhere((l) => l.id == loan.id)] = loan,
      loan,
    );
  }

  Future<AsyncValue<List<Loan>>> copy() async {
    return state.whenData((loans) => loans.sublist(0));
  }

  Future<AsyncValue<List<Loan>>> loadHistory(String loanerId) async {
    try {
      final data = await loanRepository.getHistory(loanerId);
      return AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        return state;
      }
    }
  }

  Future<AsyncValue<List<Loan>>> filterLoans(String query) async {
    return state.whenData(
      (loans) => loans
          .where(
            (loan) =>
                loan.borrower.getName().toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                loan.itemsQuantity
                    .map(
                      (e) => e.itemSimple.name.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                    )
                    .contains(true),
          )
          .toList(),
    );
  }
}

final historyLoanerLoanListProvider =
    StateNotifierProvider<
      HistoryLoanerLoanListNotifier,
      AsyncValue<List<Loan>>
    >((ref) {
      final token = ref.watch(tokenProvider);
      HistoryLoanerLoanListNotifier historyLoanerLoanListNotifier =
          HistoryLoanerLoanListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        final loanerId = ref.watch(loanerIdProvider);
        if (loanerId != "") {
          historyLoanerLoanListNotifier.loadLoan(loanerId);
        }
      });
      return historyLoanerLoanListNotifier;
    });
