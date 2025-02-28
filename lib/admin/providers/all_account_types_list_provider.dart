import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/account_types_list_provider.dart';
import 'package:myecl/generated/openapi.enums.swagger.dart';

final allAccountTypes = Provider<List<AccountType>>((ref) {
  return ref
      .watch(allAccountTypesListProvider)
      .maybeWhen(data: (data) => data, orElse: () => []);
});
