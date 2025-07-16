import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/super_admin/class/account_type.dart';
import 'package:titan/super_admin/repositories/account_type_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

import 'package:titan/tools/token_expire_wrapper.dart';

class AccountTypesNotifier extends ListNotifier<AccountType> {
  final AccountTypeRepository accountTypeRepository;
  AccountTypesNotifier({required this.accountTypeRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<AccountType>>> loadAccountTypes() async {
    return await loadList(accountTypeRepository.getAccountTypeList);
  }
}

final allAccountTypesListProvider =
    StateNotifierProvider<AccountTypesNotifier, AsyncValue<List<AccountType>>>((
      ref,
    ) {
      final accountTypeRepository = ref.watch(accountTypeRepositoryProvider);
      AccountTypesNotifier provider = AccountTypesNotifier(
        accountTypeRepository: accountTypeRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadAccountTypes();
      });
      return provider;
    });
