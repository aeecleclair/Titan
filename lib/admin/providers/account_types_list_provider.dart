import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class AccountTypesNotifier extends ListNotifierAPI<AccountType> {
  final Openapi accountTypeRepository;
  AccountTypesNotifier({required this.accountTypeRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<AccountType>>> loadAccountTypes() async {
    return await loadList(accountTypeRepository.usersAccountTypesGet);
  }
}

final allAccountTypesListProvider =
    StateNotifierProvider<AccountTypesNotifier, AsyncValue<List<AccountType>>>(
        (ref) {
  final accountTypeRepository = ref.watch(repositoryProvider);
  return AccountTypesNotifier(accountTypeRepository: accountTypeRepository)
    ..loadAccountTypes();
});
