import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/repositories/loaner_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserLoanerListNotifier extends ListNotifier<Loaner> {
  final LoanerRepository _loanerRepository = LoanerRepository();
  UserLoanerListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _loanerRepository.setToken(token);
  }

  Future<AsyncValue<List<Loaner>>> loadMyLoanerList() async {
    return await loadList(_loanerRepository.getMyLoaner);
  }

    Future<bool> addLoaner(Loaner loaner) async {
    return await add(_loanerRepository.createLoaner, loaner);
  }

  Future<bool> updateLoaner(Loaner loaner) async {
    return await update(
        _loanerRepository.updateLoaner,
        (loaners, loaner) =>
            loaners..[loaners.indexWhere((i) => i.id == loaner.id)] = loaner,
        loaner);
  }

  Future<bool> deleteLoaner(Loaner loaner) async {
    return await delete(
        _loanerRepository.deleteLoaner,
        (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
        loaner.id,
        loaner);
  }
}

final userLoanerListProvider =
    StateNotifierProvider<UserLoanerListNotifier, AsyncValue<List<Loaner>>>(
  (ref) {
    final token = ref.watch(tokenProvider);
    UserLoanerListNotifier orderListNotifier = UserLoanerListNotifier(token: token);
    tokenExpireWrapperAuth(ref, () async {
      await orderListNotifier.loadMyLoanerList();
    });
    return orderListNotifier;
  },
);


final loanerList = Provider<List<Loaner>>((ref) {
  final deliveryProvider = ref.watch(userLoanerListProvider);
  return deliveryProvider.when(data: (loans) {
    return loans;
  }, error: (error, stackTrace) {
    return [];
  }, loading: () {
    return [];
  });
});
