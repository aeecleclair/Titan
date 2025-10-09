import 'package:flutter_riverpod/flutter_riverpod.dart';

final payAmountProvider = StateNotifierProvider<PayAmountProvider, String>((
  ref,
) {
  return PayAmountProvider();
});

class PayAmountProvider extends StateNotifier<String> {
  PayAmountProvider() : super('');

  void setPayAmount(String i) {
    state = i;
  }
}
