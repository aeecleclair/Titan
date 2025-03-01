import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class LoanListNotifier extends ListNotifier2<Loan> {
  final Openapi loanRepository;
  LoanListNotifier({required this.loanRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadLoanList() async {
    return await loadList(loanRepository.loansUsersMeGet);
  }

  Future<bool> addLoan(LoanCreation loan) async {
    return await add(() => loanRepository.loansPost(body: loan), loan);
  }

  Future<bool> updateLoan(Loan loan) async {
    return await update(
      () => loanRepository.loansLoanIdPatch(loanId: loan.id, body: LoanUpdate(
        borrowerId: loan.borrower.id,
        start: loan.start,
        end: loan.end,
        notes: loan.notes,
        caution: loan.caution,
        returned: loan.returned,
        itemsBorrowed: loan.itemsQty.map((e) => e.itemSimple.id).toList(),
      )),
      (loans, loan) => loans..[loans.indexWhere((l) => l.id == loan.id)],
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
}

final loanListProvider =
    StateNotifierProvider<LoanListNotifier, AsyncValue<List<Loan>>>((ref) {
  final loanRepository = ref.watch(repositoryProvider);
  LoanListNotifier loanListNotifier =
      LoanListNotifier(loanRepository: loanRepository);
  tokenExpireWrapperAuth(ref, () async {
    await loanListNotifier.loadLoanList();
  });
  return loanListNotifier;
});
