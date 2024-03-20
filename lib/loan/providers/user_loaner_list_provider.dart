import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/repositories/loaner_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserLoanerListNotifier extends ListNotifier<Loaner> {
  final LoanerRepository loanerRepository;
  UserLoanerListNotifier({required this.loanerRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loaner>>> loadMyLoanerList() async {
    return await loadList(loanerRepository.getMyLoaner);
  }
}

final userLoanerListProvider =
    StateNotifierProvider<UserLoanerListNotifier, AsyncValue<List<Loaner>>>(
  (ref) {
    final loanerRepository = ref.watch(loanerRepositoryProvider);
    UserLoanerListNotifier userLoanerListNotifier =
        UserLoanerListNotifier(loanerRepository: loanerRepository);
    tokenExpireWrapperAuth(ref, () async {
      await userLoanerListNotifier.loadMyLoanerList();
    });
    return userLoanerListNotifier;
  },
);

final userLoanerList = Provider<List<Loaner>>((ref) {
  final userLoanerListAsync = ref.watch(userLoanerListProvider);
  return userLoanerListAsync.maybeWhen(
      data: (loans) => loans, orElse: () => []);
});
