import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class TransactionNotifier extends SingleNotifierAPI<bool> {
  Openapi get transactionRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<bool> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<bool>> refundTransaction(
    String transactionId,
    RefundInfo refund,
  ) async {
    final response = await transactionRepository
        .mypaymentTransactionsTransactionIdRefundPost(
          transactionId: transactionId,
          body: refund,
        );
    state = AsyncValue.data(response.isSuccessful);
    return state;
  }

  Future<AsyncValue<bool>> cancelTransaction(String transactionId) async {
    final response = await transactionRepository
        .mypaymentTransactionsTransactionIdCancelPost(
          transactionId: transactionId,
        );
    state = AsyncValue.data(response.isSuccessful);
    return state;
  }
}

final transactionProvider =
    NotifierProvider<TransactionNotifier, AsyncValue<bool>>(
      TransactionNotifier.new,
    );
