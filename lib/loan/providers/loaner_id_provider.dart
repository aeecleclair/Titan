import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/loan/providers/loaner_list_provider.dart';

final loanerIdProvider =
    StateNotifierProvider<LoanerIdProvider, String>((ref) {
  final deliveries = ref.watch(loanerList);
  if (deliveries.isEmpty) {
    return LoanerIdProvider("");
  } else {
    return LoanerIdProvider(deliveries.first.id);
  }
});

class LoanerIdProvider extends StateNotifier<String> {
  LoanerIdProvider(String id) : super(id);

  void setId(String i) {
    state = i;
  }
}
