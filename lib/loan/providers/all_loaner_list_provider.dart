import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';

final allLoanerList = Provider<List<Loaner>>((ref) {
  final deliveryProvider = ref.watch(loanerListProvider);
  return deliveryProvider.maybeWhen(data: (loans) => loans, orElse: () => []);
});
