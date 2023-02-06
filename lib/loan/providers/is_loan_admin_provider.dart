import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/user_loaner_list_provider.dart';

final isLoanAdmin = StateProvider<bool>((ref) {
  final loaners = ref.watch(userLoanerListProvider);
  final loanersName = loaners.when(
      data: (loaners) => loaners.map((e) => e.name).toList(),
      loading: () => [],
      error: (error, stackTrace) => []);
  return loanersName.isNotEmpty;
});
