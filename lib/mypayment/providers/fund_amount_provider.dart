import 'package:flutter_riverpod/flutter_riverpod.dart';

class FundAmountProvider extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void setFundAmount(String i) {
    state = i;
  }
}

final fundAmountProvider = NotifierProvider<FundAmountProvider, String>(
  FundAmountProvider.new,
);
