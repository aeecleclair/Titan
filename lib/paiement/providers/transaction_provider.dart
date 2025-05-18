import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/refund.dart';
import 'package:myecl/paiement/repositories/transaction_repository.dart';
import 'package:myecl/tools/providers/single_notifier.dart';

class TransactionNotifier extends SingleNotifier<bool> {
  final TransactionsRepository transactionRepository;
  TransactionNotifier({required this.transactionRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<bool>> refundTransaction(
    String transactionId,
    Refund refund,
  ) async {
    return await load(
      () => transactionRepository.refundTransaction(transactionId, refund),
    );
  }

  Future<AsyncValue<bool>> cancelTransaction(String transactionId) async {
    return await load(
      () => transactionRepository.cancelTransaction(transactionId),
    );
  }
}

final transactionProvider =
    StateNotifierProvider<TransactionNotifier, AsyncValue<bool>>((ref) {
  final transactionRepository = ref.watch(transactionsRepositoryProvider);
  return TransactionNotifier(transactionRepository: transactionRepository);
});
