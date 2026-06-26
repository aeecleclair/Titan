import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/providers/user_loaner_list_provider.dart';

final isLoanAdminProvider = Provider<bool>((ref) {
  final loaners = ref.watch(userLoanerListProvider);
  final loanersName = loaners.maybeWhen(
    data: (loaners) => loaners.map((e) => e.name).toList(),
    orElse: () => [],
  );
  return loanersName.isNotEmpty;
});
