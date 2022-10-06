import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/repositories/loaner_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class UserLoanerListNotifier extends ListNotifier<Loaner> {
  final LoanerRepository _loanerRepository = LoanerRepository();
  UserLoanerListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _loanerRepository.setToken(token);
  }

  Future<AsyncValue<List<Loaner>>> loadMyLoanerList() async {
    return await loadList(_loanerRepository.getMyLoaner);
  }
}

final userLoanerListProvider =
    StateNotifierProvider<UserLoanerListNotifier, AsyncValue<List<Loaner>>>(
  (ref) {
    final token = ref.watch(tokenProvider);
    UserLoanerListNotifier orderListNotifier = UserLoanerListNotifier(token: token);
    orderListNotifier.loadMyLoanerList();
    return orderListNotifier;
  },
);