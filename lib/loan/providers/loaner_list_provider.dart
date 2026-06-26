import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class LoanerListNotifier extends ListNotifierAPI<Loaner> {
  Openapi get loanerRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<Loaner>> build() {
    loadLoanerList();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<Loaner>>> loadLoanerList() async {
    return await loadList(loanerRepository.loansLoanersGet);
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

final loanerListProvider =
    NotifierProvider<LoanerListNotifier, AsyncValue<List<Loaner>>>(
      LoanerListNotifier.new,
    );
