import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/loan/providers/user_loaner_list_provider.dart';

class LoanerIdProvider extends Notifier<String> {
  @override
  String build() {
    final deliveries = ref.watch(loanerList);
    if (deliveries.isEmpty) {
      return "";
    }
    return deliveries.first.id;
  }

  void setId(String i) {
    state = i;
  }
}

final loanerIdProvider = NotifierProvider<LoanerIdProvider, String>(
  LoanerIdProvider.new,
);
