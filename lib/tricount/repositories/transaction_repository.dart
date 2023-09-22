import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tricount/class/transaction.dart';

class TransactionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tricount/group/";

  Future<bool> createTransaction(
      String sharerGroupId, Transaction transaction) async {
    return await update(transaction.toJson(), "$sharerGroupId/transaction");
  }

  Future<bool> deleteTransaction(
      String sharerGroupId, String transactionId) async {
    return await delete("$sharerGroupId/transaction/$transactionId");
  }
}
