import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class UserLoanerListNotifier extends ListNotifierAPI<Loaner> {
  Openapi get loanerRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Loaner>> build() {
    loadMyLoanerList();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Loaner>>> loadMyLoanerList() async {
    return await loadList(loanerRepository.loansUsersMeLoanersGet);
  }

  Future<bool> addLoaner(LoanerBase loaner) async {
    return await add(
      () => loanerRepository.loansLoanersPost(body: loaner),
      loaner,
    );
  }

  Future<bool> updateLoaner(Loaner loaner) async {
    return await update(
      () => loanerRepository.loansLoanersLoanerIdPatch(
        loanerId: loaner.id,
        body: LoanerUpdate(
          name: loaner.name,
          groupManagerId: loaner.groupManagerId,
        ),
      ),
      (loaner) => loaner.id,
      loaner,
    );
  }

  Future<bool> deleteLoaner(Loaner loaner) async {
    return await delete(
      () => loanerRepository.loansLoanersLoanerIdDelete(loanerId: loaner.id),
      (loaner) => loaner.id,
      loaner.id,
    );
  }
}

final userLoanerListProvider =
    NotifierProvider<UserLoanerListNotifier, AsyncValue<List<Loaner>>>(
      UserLoanerListNotifier.new,
    );

final loanerList = Provider<List<Loaner>>((ref) {
  final deliveryProvider = ref.watch(userLoanerListProvider);
  return deliveryProvider.maybeWhen(data: (loans) => loans, orElse: () => []);
});
