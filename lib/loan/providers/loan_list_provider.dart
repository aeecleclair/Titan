import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class LoanListNotifier extends ListNotifier2<Loan> {
  final Openapi loanRepository;
  LoanListNotifier({required this.loanRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loan>>> loadLoanList() async {
    return await loadList(loanRepository.loansUsersMeGet);
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
