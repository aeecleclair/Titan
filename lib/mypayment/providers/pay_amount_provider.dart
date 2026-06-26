import 'package:flutter_riverpod/flutter_riverpod.dart';

final payAmountProvider = NotifierProvider<PayAmountProvider, String>(
  PayAmountProvider.new,
);

class PayAmountProvider extends Notifier<String> {
  @override
  String build() => '';

  void setPayAmount(String i) {
    state = i;
  }
}
