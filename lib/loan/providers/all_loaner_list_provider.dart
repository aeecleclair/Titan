import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/class/loaner.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';

final allLoanerListProvider = Provider<List<Loaner>>((ref) {
  final loaners = ref.watch(loanerListProvider);
  return loaners.maybeWhen(data: (loans) => loans, orElse: () => []);
});
