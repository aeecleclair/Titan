import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/class/loaner.dart';
import 'package:titan/loan/repositories/loaner_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class UserLoanerListNotifier extends ListNotifier<Loaner> {
  final LoanerRepository loanerRepository;
  UserLoanerListNotifier({required this.loanerRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loaner>>> loadMyLoanerList() async {
    return await loadList(loanerRepository.getMyLoaner);
  }

  Future<bool> addLoaner(Loaner loaner) async {
    return await add(loanerRepository.createLoaner, loaner);
  }

  Future<bool> updateLoaner(Loaner loaner) async {
    return await update(
      loanerRepository.updateLoaner,
      (loaners, loaner) =>
          loaners..[loaners.indexWhere((i) => i.id == loaner.id)] = loaner,
      loaner,
    );
  }

  Future<bool> deleteLoaner(Loaner loaner) async {
    return await delete(
      loanerRepository.deleteLoaner,
      (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
      loaner.id,
      loaner,
    );
  }
}

final userLoanerListProvider =
    StateNotifierProvider<UserLoanerListNotifier, AsyncValue<List<Loaner>>>((
      ref,
    ) {
      final loanerRepository = ref.watch(loanerRepositoryProvider);
      UserLoanerListNotifier orderListNotifier = UserLoanerListNotifier(
        loanerRepository: loanerRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await orderListNotifier.loadMyLoanerList();
      });
      return orderListNotifier;
    });

final loanerList = Provider<List<Loaner>>((ref) {
  final deliveryProvider = ref.watch(userLoanerListProvider);
  return deliveryProvider.maybeWhen(data: (loans) => loans, orElse: () => []);
});
