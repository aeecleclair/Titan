import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserLoanerListNotifier extends ListNotifier2<Loaner> {
  final Openapi loanerRepository;
  UserLoanerListNotifier({required this.loanerRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<Loaner>>> loadMyLoanerList() async {
    return await loadList(loanerRepository.loansUsersMeLoanersGet);
  }

  Future<bool> addLoaner(LoanerBase loaner) async {
    return await add(
        () => loanerRepository.loansLoanersPost(body: loaner), loaner);
  }

  Future<bool> updateLoaner(Loaner loaner) async {
    return await update(
      () => loanerRepository.loansLoanersLoanerIdPatch(
          loanerId: loaner.id,
          body: LoanerUpdate(
            name: loaner.name,
            groupManagerId: loaner.groupManagerId,
          )),
      (loaners, loaner) =>
          loaners..[loaners.indexWhere((i) => i.id == loaner.id)] = loaner,
      loaner,
    );
  }

  Future<bool> deleteLoaner(Loaner loaner) async {
    return await delete(
      () => loanerRepository.loansLoanersLoanerIdDelete(loanerId: loaner.id),
      (loans, loan) => loans..removeWhere((i) => i.id == loan.id),
      loaner,
    );
  }
}

final userLoanerListProvider =
    StateNotifierProvider<UserLoanerListNotifier, AsyncValue<List<Loaner>>>(
  (ref) {
    final loanerRepository = ref.watch(repositoryProvider);
    UserLoanerListNotifier orderListNotifier =
        UserLoanerListNotifier(loanerRepository: loanerRepository);
    tokenExpireWrapperAuth(ref, () async {
      await orderListNotifier.loadMyLoanerList();
    });
    return orderListNotifier;
  },
);

final loanerList = Provider<List<Loaner>>((ref) {
  final deliveryProvider = ref.watch(userLoanerListProvider);
  return deliveryProvider.maybeWhen(data: (loans) => loans, orElse: () => []);
});
