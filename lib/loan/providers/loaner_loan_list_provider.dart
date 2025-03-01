import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/extensions/users.dart';

class LoanerLoanListNotifier extends ListNotifier2<Loan> {
  final Openapi loanRepository;
  LoanerLoanListNotifier({required this.loanRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadLoan(String loanerId) async {
    return await loadList(
      () async =>
          loanRepository.loansLoanersLoanerIdLoansGet(loanerId: loanerId),
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
            itemsBorrowed: loan.itemsQty.map(
              (e) => e.itemSimple.id,
            ),
          )),
      (loans, loan) => loans..[loans.indexWhere((l) => l.id == loan.id)] = loan,
      loan,
    );
  }

  Future<bool> deleteLoan(Loan loan) async {
    return await delete(
      () => loanRepository.loansLoanIdDelete(loanId: loan.id),
      (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
      loan,
    );
  }

  Future<bool> returnLoan(Loan loan) async {
    return await delete(
      () => loanRepository.loansLoanIdReturnPost(loanId: loan.id),
      (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
      loan,
    );
  }

  Future<bool> extendLoan(Loan loan, int delay) async {
    return await update(
      () => loanRepository.loansLoanIdExtendPost(
          loanId: loan.id, body: LoanExtend(duration: delay)),
      (loans, loan) => loans..[loans.indexWhere((l) => l.id == loan.id)] = loan,
      loan,
    );
  }

  Future<AsyncValue<List<Loan>>> copy() async {
    return state.whenData((loans) => loans.sublist(0));
  }

  Future<AsyncValue<List<Loan>>> loadHistory(String loanerId) async {
    try {
      final data = await loanRepository.loansLoanersLoanerIdLoansGet(
          loanerId: loanerId, returned: true);
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
                loan.borrower
                    .getName()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                loan.itemsQty
                    .map(
                      (e) => e.itemSimple.name
                          .toLowerCase()
                          .contains(query.toLowerCase()),
                    )
                    .contains(true),
          )
          .toList(),
    );
  }
}

final loanerLoanListProvider =
    StateNotifierProvider<LoanerLoanListNotifier, AsyncValue<List<Loan>>>(
        (ref) {
  final loanerRepository = ref.watch(repositoryProvider);
  LoanerLoanListNotifier loanerLoanListNotifier =
      LoanerLoanListNotifier(loanRepository: loanerRepository);
  tokenExpireWrapperAuth(ref, () async {
    final loanerId = ref.watch(loanerIdProvider);
    if (loanerId != "") {
      loanerLoanListNotifier.loadLoan(loanerId);
    }
  });
  return loanerLoanListNotifier;
});
