import 'package:flutter_riverpod/flutter_riverpod.dart';

final fundAmountProvider = StateNotifierProvider<FundAmountProvider, String>((
  ref,
) {
  return FundAmountProvider();
});

class FundAmountProvider extends StateNotifier<String> {
  FundAmountProvider() : super('');

  void setFundAmount(String i) {
    state = i;
  }
}
