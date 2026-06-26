import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.enums.swagger.dart' as enums;
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class AccountTypesNotifier extends ListNotifierAPI<enums.AccountType> {
  Openapi get accountTypeRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<enums.AccountType>> build() {
    loadAccountTypes();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<enums.AccountType>>> loadAccountTypes() async {
    return await loadList(accountTypeRepository.usersAccountTypesGet);
  }
}

final allAccountTypesListProvider =
    NotifierProvider<AccountTypesNotifier, AsyncValue<List<enums.AccountType>>>(
      AccountTypesNotifier.new,
    );
