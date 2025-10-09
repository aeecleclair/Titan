import 'package:flutter_riverpod/flutter_riverpod.dart';

final refundAmountProvider =
    StateNotifierProvider<RefundAmountProvider, String>((ref) {
      return RefundAmountProvider();
    });

class RefundAmountProvider extends StateNotifier<String> {
  RefundAmountProvider() : super('');

  void setRefundAmount(String i) {
    state = i;
  }
}
