import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/generated/openapi.models.swagger.dart';

class OngoingTransaction extends Notifier<AsyncValue<History>> {
  @override
  AsyncValue<History> build() {
    return const AsyncValue.loading();
  }

  void updateOngoingTransaction(AsyncValue<History> transaction) {
    state = transaction;
  }

  void clearOngoingTransaction() {
    state = const AsyncValue.loading();
  }
}

final ongoingTransactionProvider =
    NotifierProvider<OngoingTransaction, AsyncValue<History>>(
      OngoingTransaction.new,
    );
