import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/loan/class/loaner.dart';
import 'package:titan/loan/repositories/loaner_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class LoanerListNotifier extends ListNotifier<Loaner> {
  final LoanerRepository loanerRepository;
  LoanerListNotifier({required this.loanerRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loaner>>> loadLoanerList() async {
    return await loadList(loanerRepository.getLoanerList);
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

final loanerListProvider =
    StateNotifierProvider<LoanerListNotifier, AsyncValue<List<Loaner>>>((ref) {
      final loanerRepository = ref.watch(loanerRepositoryProvider);
      LoanerListNotifier orderListNotifier = LoanerListNotifier(
        loanerRepository: loanerRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await orderListNotifier.loadLoanerList();
      });
      return orderListNotifier;
    });
