import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/loan/providers/loaner_id_provider.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';

final loanerProvider = Provider((ref) {
  final loanerId = ref.watch(loanerIdProvider);
  final loanerList = ref.watch(userLoanerListProvider);
  return loanerList.maybeWhen(
    data: (loanerList) =>
        loanerList.firstWhere((loaner) => loaner.id == loanerId),
    orElse: () => Loaner.fromJson({}),
  );
});
