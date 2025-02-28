import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';

import 'package:myecl/tools/token_expire_wrapper.dart';

class AccountTypesNotifier extends ListNotifier2<AccountType> {
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
  AccountTypesNotifier provider =
      AccountTypesNotifier(accountTypeRepository: accountTypeRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadAccountTypes();
  });
  return provider;
});
