import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/mypayment/class/refund.dart';
import 'package:titan/tools/repository/repository.dart';

class TransactionsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'mypayment/transactions';

  Future<bool> refundTransaction(String transactionId, Refund refund) async {
    return await create(refund.toJson(), suffix: '/$transactionId/refund');
  }

  Future<bool> cancelTransaction(String transactionId) async {
    return await create({}, suffix: '/$transactionId/cancel');
  }
}

final transactionsRepositoryProvider = Provider<TransactionsRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return TransactionsRepository()..setToken(token);
});
