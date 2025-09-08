import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/paiement/class/transaction.dart';

class OngoingTransaction extends StateNotifier<AsyncValue<Transaction>> {
  OngoingTransaction() : super(const AsyncValue.loading());

  void updateOngoingTransaction(AsyncValue<Transaction> transaction) {
    state = transaction;
  }

  void clearOngoingTransaction() {
    state = const AsyncValue.loading();
  }
}

final ongoingTransactionProvider =
    StateNotifierProvider<OngoingTransaction, AsyncValue<Transaction>>((ref) {
      return OngoingTransaction();
    });
