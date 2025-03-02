import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/loan/adapters/loan.dart';

class LoanListNotifier extends ListNotifierAPI<Loan> {
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
      () => loanRepository.loansLoanIdPatch(
        loanId: loan.id,
        body: loan.toLoanUpdate(),
      ),
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
