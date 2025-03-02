import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/extensions/users.dart';
import 'package:myecl/loan/adapters/loan.dart';

class LoanerLoanListNotifier extends ListNotifierAPI<Loan> {
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
          loanId: loan.id, body: loan.toLoanUpdate()),
      (loan) => loan.id,
      loan,
    );
  }

  Future<bool> deleteLoan(String loanId) async {
    return await delete(
      () => loanRepository.loansLoanIdDelete(loanId: loanId),
      (l) => l.id,
      loanId,
    );
  }

  Future<bool> returnLoan(String loanId) async {
    return await delete(
      () => loanRepository.loansLoanIdReturnPost(loanId: loanId),
      (l) => l.id,
      loanId,
    );
  }

  Future<bool> extendLoan(Loan loan, int delay) async {
    return await update(
      () => loanRepository.loansLoanIdExtendPost(
          loanId: loan.id, body: loan.toLoanExtend(delay)),
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
