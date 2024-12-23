import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/account_type.dart';
import 'package:myecl/admin/providers/account_types_list_provider.dart';

final allAccountTypes = Provider<List<AccountType>>((ref) {
  return ref
      .watch(allAccountTypesListProvider)
      .maybeWhen(data: (data) => data, orElse: () => []);
});
