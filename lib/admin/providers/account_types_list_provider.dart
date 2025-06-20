import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/account_type.dart';
import 'package:myecl/admin/repositories/account_type_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

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
      provider.loadAccountTypes();
      return provider;
    });
