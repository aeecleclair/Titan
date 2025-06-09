import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/admin/class/account_type.dart';
import 'package:myemapp/admin/providers/account_types_list_provider.dart';

final allAccountTypes = Provider<List<AccountType>>((ref) {
  return ref
      .watch(allAccountTypesListProvider)
      .maybeWhen(data: (data) => data, orElse: () => []);
});
