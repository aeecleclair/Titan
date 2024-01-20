import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/tricount/class/transaction.dart';

class TransactionRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tricount/transactions";

  Future<bool> createTransaction(Transaction transaction) async {
    return await create(transaction.toJson());
  }

  Future<bool> deleteTransaction(String transactionId) async {
    return await delete("/$transactionId");
  }

  Future<bool> updateTransaction(Transaction transaction) async {
    return await update(transaction.toJson(), "/${transaction.id}");
  }
}
