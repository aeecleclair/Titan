import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class LoanListNotifier extends ListNotifierAPI<Loan> {
  Openapi get loanRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Loan>> build() {
    loadLoanList();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Loan>>> loadLoanList() async {
    return await loadList(loanRepository.loansUsersMeGet);
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
}

final loanListProvider =
    NotifierProvider<LoanListNotifier, AsyncValue<List<Loan>>>(
      LoanListNotifier.new,
    );
