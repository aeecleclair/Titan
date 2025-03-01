import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/loan/adapters/loaner.dart';

class UserLoanerListNotifier extends ListNotifierAPI<Loaner> {
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
          loanerId: loaner.id, body: loaner.toLoanerUpdate()),
      (loaner) => loaner.id,
      loaner,
    );
  }

  Future<bool> deleteLoaner(Loaner loaner) async {
    return await delete(
      () => loanerRepository.loansLoanersLoanerIdDelete(loanerId: loaner.id),
      (loans) => loans..removeWhere((i) => i.id == loaner.id),
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
