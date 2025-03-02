import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/loan/adapters/loaner.dart';

class LoanerListNotifier extends ListNotifierAPI<Loaner> {
  final Openapi loanerRepository;
  LoanerListNotifier({required this.loanerRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loaner>>> loadLoanerList() async {
    return await loadList(loanerRepository.loansLoanersGet);
  }

  Future<bool> addLoaner(LoanerBase loaner) async {
    return await add(
        () => loanerRepository.loansLoanersPost(body: loaner), loaner);
  }

  Future<bool> updateLoaner(Loaner loaner) async {
    return await update(
      () => loanerRepository.loansLoanersLoanerIdPatch(
        loanerId: loaner.id,
        body: loaner.toLoanerUpdate(),
      ),
      (loaner) => loaner.id,
      loaner,
    );
  }

  Future<bool> deleteLoaner(Loaner loaner) async {
    return await delete(
      () => loanerRepository.loansLoanersLoanerIdDelete(loanerId: loaner.id),
      (l) => l.id,
      loaner.id,
    );
  }
}

final loanerListProvider =
    StateNotifierProvider<LoanerListNotifier, AsyncValue<List<Loaner>>>(
  (ref) {
    final loanerRepository = ref.watch(repositoryProvider);
    LoanerListNotifier orderListNotifier =
        LoanerListNotifier(loanerRepository: loanerRepository);
    tokenExpireWrapperAuth(ref, () async {
      await orderListNotifier.loadLoanerList();
    });
    return orderListNotifier;
  },
);
