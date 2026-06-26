import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/loan/providers/loaner_id_provider.dart';
import 'package:titan/tools/exception.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/user/extensions/core_user_simple.dart';

class HistoryLoanerLoanListNotifier extends ListNotifierAPI<Loan> {
  Openapi get loanRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Loan>> build() {
    final loanerId = ref.watch(loanerIdProvider);
    if (loanerId != "") {
      loadLoan(loanerId);
    }
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Loan>>> loadLoan(String loanerId) async {
    return await loadList(
      () async => loanRepository.loansLoanersLoanerIdLoansGet(
        loanerId: loanerId,
        returned: true,
      ),
    );
  }

  Future<bool> addLoan(LoanCreation loan) async {
    return await add(() => loanRepository.loansPost(body: loan), loan);
  }

  Future<bool> updateLoan(Loan loan) async {
    return await update(
      () => loanRepository.loansLoanIdPatch(
        loanId: loan.id,
        body: LoanUpdate(
          borrowerId: loan.borrower.id,
          start: loan.start,
          end: loan.end,
          notes: loan.notes,
          caution: loan.caution,
          returned: loan.returned,
          itemsBorrowed: loan.itemsQty
              .map(
                (e) =>
                    ItemBorrowed(itemId: e.itemSimple.id, quantity: e.quantity),
              )
              .toList(),
        ),
      ),
      (loan) => loan.id,
      loan,
    );
  }

  Future<bool> deleteLoan(Loan loan) async {
    return await delete(
      () => loanRepository.loansLoanIdDelete(loanId: loan.id),
      (loan) => loan.id,
      loan.id,
    );
  }

  Future<bool> returnLoan(Loan loan) async {
    return await delete(
      () => loanRepository.loansLoanIdReturnPost(loanId: loan.id),
      (loan) => loan.id,
      loan.id,
    );
  }

  Future<bool> extendLoan(Loan loan, int delay) async {
    return await update(
      () => loanRepository.loansLoanIdExtendPost(
        loanId: loan.id,
        body: LoanExtend(duration: delay),
      ),
      (loan) => loan.id,
      loan,
    );
  }

  Future<AsyncValue<List<Loan>>> copy() async {
    return state.whenData((loans) => loans.sublist(0));
  }

  Future<AsyncValue<List<Loan>>> loadHistory(String loanerId) async {
    try {
      final data = await loanRepository.loansLoanersLoanerIdLoansGet(
        loanerId: loanerId,
        returned: true,
      );
      if (data.isSuccessful) {
        return AsyncValue.data(data.body!);
      }
      return AsyncValue.error("Error", StackTrace.current);
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
                loan.itemsQty
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
    NotifierProvider<HistoryLoanerLoanListNotifier, AsyncValue<List<Loan>>>(
      () => HistoryLoanerLoanListNotifier(),
    );
