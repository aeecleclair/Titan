import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/providers/user_loaner_list_provider.dart';

final loanerIdProvider = StateNotifierProvider<LoanerIdProvider, String>((ref) {
  final deliveries = ref.watch(loanerList);
  if (deliveries.isEmpty) {
    return LoanerIdProvider("");
  }
  return LoanerIdProvider(deliveries.first.id);
});

class LoanerIdProvider extends StateNotifier<String> {
  LoanerIdProvider(super.id);

  void setId(String i) {
    state = i;
  }
}
