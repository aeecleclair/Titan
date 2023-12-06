import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/admin/tools/functions.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class LoanerLoanListNotifier extends ListNotifier2<Loan> {
  final Openapi loanRepository;
  LoanerLoanListNotifier({required this.loanRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadLoan(String loanerId) async {
    return await loadList(
        () async => loanRepository.loansLoanersLoanerIdLoansGet(
              loanerId: loanerId,
              returned: true,
            ));
  }

  Future<bool> addLoan(Loan loan) async {
    return await add(
        (loan) async => loanRepository.loansPost(
                body: LoanCreation(
              borrowerId: loan.borrower.id,
              loanerId: loan.loaner.id,
              start: loan.start,
              end: loan.end,
              notes: loan.notes,
              caution: loan.caution,
              itemsBorrowed: loan.itemsQty
                  .map((e) => ItemBorrowed(
                        itemId: e.itemSimple.id,
                        quantity: e.quantity,
                      ))
                  .toList(),
            )),
        loan);
  }

  Future<bool> updateLoan(Loan loan) async {
    return await update(
        (loan) async => loanRepository.loansLoanIdPatch(
            loanId: loan.id,
            body: LoanUpdate(
              borrowerId: loan.borrower.id,
              start: loan.start,
              end: loan.end,
              notes: loan.notes,
              caution: loan.caution,
              itemsBorrowed: loan.itemsQty
                  .map((e) => ItemBorrowed(
                        itemId: e.itemSimple.id,
                        quantity: e.quantity,
                      ))
                  .toList(),
            )),
        (loans, loan) =>
            loans..[loans.indexWhere((l) => l.id == loan.id)] = loan,
        loan);
  }

  Future<bool> deleteLoan(Loan loan) async {
    return await delete(
        (loanId) async => loanRepository.loansLoanIdDelete(loanId: loanId),
        (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
        loan.id,
        loan);
  }

  Future<bool> returnLoan(Loan loan) async {
    return await delete(
        (loanId) async => loanRepository.loansLoanIdReturnPost(loanId: loanId),
        (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
        loan.id,
        loan);
  }

  Future<bool> extendLoan(Loan loan, double delay) async {
    return await update(
        (loan) async => loanRepository.loansLoanIdExtendPost(
            loanId: loan.id, body: LoanExtend(duration: delay)),
        (loans, loan) =>
            loans..[loans.indexWhere((l) => l.id == loan.id)] = loan,
        loan);
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
